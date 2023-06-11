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

  CollectionReference product =
      FirebaseFirestore.instance.collection('shoppingBasket');

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color: const Color(0xFFAAC4FF),
              height: 30,
            ),
            Container(
              height: 50,
              color: const Color(0xFFAAC4FF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 0, right: 0),
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
                  const Text(
                    "장바구니",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 30,
                    margin: const EdgeInsets.only(left: 190),
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
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.8,
              color: Colors.black,
            ),
            Container(
              height: 645,
              color: Colors.white,
              child: StreamBuilder(
                stream: product.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<dynamic> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: () {
                            debugPrint("터치");
                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: 10, top: 10, bottom: 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Color(0xFFAAC4FF),
                                          child: Column(
                                            children: [
                                              Text(
                                                documentSnapshot['storeName'],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                documentSnapshot['location'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 1.8,
                                          color: Colors.black54,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 30, top: 20),
                                              child: Text(
                                                documentSnapshot['name'],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                documentSnapshot['price'] + '원',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
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
            Container(
              height: 100,
              color: const Color(0xFFAAC4FF),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 15, top: 20),
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
                      margin: const EdgeInsets.only(top: 55, right: 15),
                      child: Text(
                        '0원',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Payment()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  color: Color(0xffB1B2FF),
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
