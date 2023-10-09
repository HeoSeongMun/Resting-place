import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/payment.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _Cart();
}

class _Cart extends State<Cart> {
  String storeName = "";
  String areaName = "";
  String name = "";
  String price = "";
  String location = "";
  String userUid = "";
  int total = 0;
  CollectionReference product =
      FirebaseFirestore.instance.collection('shoppingBasket');
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  final user = FirebaseAuth.instance.currentUser;

  int calculateTotal(QuerySnapshot snapshot) {
    total = 0;
    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      int fieldValue = int.parse(data['price']);
      int count = data['count'];
      total += (fieldValue * count);
    }

    return total;
  }

  int cartcount = 0;
  Future<void> CartCount() async {
    QuerySnapshot snapshot =
        await product.where('userUid', isEqualTo: user!.uid).get();

    int count = snapshot.docs.length;

    setState(() {
      cartcount = count;
    });
  }

  int ordercount = 0;
  Future<void> OrderCount() async {
    QuerySnapshot snapshot = await ordercollection
        .where('userUid', isEqualTo: user!.uid)
        .where('status', isNotEqualTo: '완료')
        .get();

    int count = snapshot.docs.length;

    setState(() {
      ordercount = count;
    });
  }

  @override
  void initState() {
    super.initState();
    CartCount();
    OrderCount();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFEEF1FF),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 110,
              padding: const EdgeInsets.only(top: 35, right: 15, left: 5),
              decoration: BoxDecoration(
                  color: const Color(0xFFD2DAFF),
                  borderRadius: const BorderRadius.only(
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
                        Navigator.pop(context, cartcount);
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
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
                  SizedBox(
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
                        setState(() {
                          CartCount();
                          OrderCount();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 315,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: const Color(0xFFC5DFF8),
                  borderRadius: const BorderRadius.only(
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
                margin: const EdgeInsets.only(left: 5, right: 5),
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
                          int itemPrice = int.parse(documentSnapshot[
                              'price']); // 아이템의 가격 (int 형으로 가정)
                          int itemcount = documentSnapshot['count'];

                          int listlPrice = itemPrice * itemcount;
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 15),
                            decoration: BoxDecoration(
                                color: const Color(0xFFffffff),
                                borderRadius: const BorderRadius.only(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFB79E),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              documentSnapshot['storeName'],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              documentSnapshot['location'],
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        width: 45,
                                        child: ElevatedButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 255, 255),
                                            side: const BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                          ),
                                          child: const Text(
                                            "삭제",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            documentSnapshot.reference.delete();
                                            setState(() {
                                              CartCount();
                                              OrderCount();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, top: 10),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.network(
                                          documentSnapshot['imageUrl'],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      margin: const EdgeInsets.only(
                                          left: 20, top: 10),
                                      child: Text(
                                        documentSnapshot['name'],
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: 90,
                                      height: 45,
                                      margin: const EdgeInsets.only(
                                          top: 10, left: 10),
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFFB79E),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.0),
                                          topRight: Radius.circular(25.0),
                                          bottomLeft: Radius.circular(25.0),
                                          bottomRight: Radius.circular(25.0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 30,
                                            height: 30,
                                            margin: const EdgeInsets.only(
                                                bottom: 7),
                                            child: IconButton(
                                              icon: const Icon(Icons.remove,
                                                  size: 20),
                                              onPressed: () async {
                                                //감소
                                                // 현재 아이템의 수량 가져오기
                                                if (documentSnapshot['count'] >
                                                    1) {
                                                  await product
                                                      .doc(documentSnapshot.id)
                                                      .update({
                                                    'count': documentSnapshot[
                                                            'count'] -
                                                        1,
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 25,
                                            height: 30,
                                            child: Text(
                                              documentSnapshot['count']
                                                  .toString(), // 해당 제품의 수량 표시
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 30,
                                            height: 30,
                                            margin: const EdgeInsets.only(
                                                bottom: 7),
                                            child: IconButton(
                                              icon: const Icon(Icons.add,
                                                  size: 20),
                                              onPressed: () async {
                                                // 증가
                                                // 현재 아이템의 수량 가져오기
                                                await product
                                                    .doc(documentSnapshot.id)
                                                    .update({
                                                  'count': documentSnapshot[
                                                          'count'] +
                                                      1,
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 20, bottom: 5),
                                    child: Text(
                                      '$listlPrice원',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            const SizedBox(
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
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              // 오류 발생 시 오류 메시지 출력
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              // 데이터가 없을 경우 처리
                              return const Text(
                                '0원',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            // 결과 출력
                            total = calculateTotal(snapshot.data!);
                            return Text(
                              '$total원',
                              style: const TextStyle(
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
                              children: const [
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
                                  child: const Text(
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
                  color: const Color(0xffFFB79E),
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
