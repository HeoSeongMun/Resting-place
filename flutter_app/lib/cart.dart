import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/payment.dart';
import 'package:flutter_app/signup.dart';

class Cart extends StatelessWidget {
  Cart({super.key});

  String storeName = "";
  String areaName = "";
  String name = "";
  String price = "";
  String location = "";
  String userUid = "";
  int total = 0;
  CollectionReference product =
      FirebaseFirestore.instance.collection('shoppingBasket');

  final user = FirebaseAuth.instance.currentUser;

  int calculateTotal(QuerySnapshot snapshot) {
    total = 0;

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      int fieldValue = int.parse(data['price']);
      total += fieldValue;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 110,
              padding: EdgeInsets.only(top: 35, right: 15, left: 5),
              decoration: BoxDecoration(
                  color: Color(0xFFD2DAFF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: const Offset(0, 7),
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 60,
                    height: 60,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 35,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      alignment: Alignment.center,
                      width: 220,
                      child: const Text(
                        "장바구니",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 30,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: const Text(
                        "전체삭제",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        Query query =
                            product.where('userUid', isEqualTo: user!.uid);
                        QuerySnapshot querySnapshot = await query.get();
                        List<QueryDocumentSnapshot> documents =
                            querySnapshot.docs;
                        for (QueryDocumentSnapshot document in documents) {
                          // 'name', 'price', 'storeName' 필드 값 가져오기
                          name = document.get('name');
                          price = document.get('price');
                          storeName = document.get('storeName');
                          location = document.get('location');
                          userUid = document.get('userUid');
                        }
                        for (QueryDocumentSnapshot document in documents) {
                          await document.reference.delete();
                        }
                        total = 0;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 315,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Color(0xFFC5DFF8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: const Offset(0, 7),
                    ),
                  ]),
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: StreamBuilder(
                  stream: product
                      .where('userUid', isEqualTo: user!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return GestureDetector(
                            onTap: () {
                              debugPrint("터치");
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 5, right: 5, bottom: 15),
                              decoration: BoxDecoration(
                                  color: Color(0xFFffffff),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                    bottomLeft: Radius.circular(25.0),
                                    bottomRight: Radius.circular(25.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      blurRadius: 5,
                                      spreadRadius: 0,
                                      offset: const Offset(0, 7),
                                    ),
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFB79E),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            documentSnapshot['storeName'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            documentSnapshot['location'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 20, top: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.network(
                                            documentSnapshot['imageUrl'],
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 20, top: 10),
                                        child: Text(
                                          documentSnapshot['name'],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 20, bottom: 5),
                                        child: Text(
                                          documentSnapshot['price'] + '원',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: const Color(0xFFD2DAFF),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 15, top: 10),
                      child: const Text(
                        "총 주문 금액",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 40, right: 15),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: product.snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // 데이터 가져오는 중 로딩 상태
                              return CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              // 오류 발생 시 오류 메시지 출력
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              // 데이터가 없을 경우 처리
                              return Text(
                                '0원',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            // 결과 출력
                            int total = calculateTotal(snapshot.data!);
                            return Text(
                              '$total원',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (total == 0) {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '상품이 없습니다.!',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '상품을 추가해주세요.!',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                          actions: <Widget>[
                            Container(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "닫기",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Payment(total: total.toString())),
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  color: Color(0xffFFB79E),
                  child: const Text(
                    "주문하기",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
