import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/payment.dart';
import 'package:flutter_app/signup.dart';

class Cart extends StatelessWidget {
  String storeName = "";
  String areaName = "";
  Cart(this.storeName, this.areaName, {super.key});

  CollectionReference product =
      FirebaseFirestore.instance.collection('shoppingBasket');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              height: 50,
              color: Color(0xFFAAC4FF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0, right: 0),
                    width: 60,
                    height: 60,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 35,
                      color: Color.fromARGB(255, 0, 0, 0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    "장바구니",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 30,
                    margin: EdgeInsets.only(left: 190),
                    child: ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          primary: Colors.black,
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          side: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "전체삭제",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.8,
              color: Colors.black,
            ),
            Container(
              height: 100,
              color: Color(0xFFAAC4FF),
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeName,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      areaName,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1.5,
              color: Colors.black,
            ),
            Container(
              height: 400,
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
                          return Card(
                            child: ListTile(
                              title: Text(documentSnapshot['name']),
                              subtitle: Text(documentSnapshot['price']),
                              onTap: () {},
                            ),
                          );
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              height: 100,
              color: Color(0xFFAAC4FF),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 15, top: 20),
                  child: Text(
                    "총 주문 금액",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 170, top: 50),
                  child: Text(
                    "0원",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  minimumSize: Size(400, 50),
                  primary: Colors.black,
                  backgroundColor: Color(0xFFB1B2FF),
                  side: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Payment(),
                    ),
                  );
                },
                child: Text(
                  "주문하기",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

Future<void> _delete(String productId) async {
  await product.doc(productId).delete();
}
