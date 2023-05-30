import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/payment.dart';
import 'package:flutter_app/signup.dart';

class Cart extends StatelessWidget {
  String storeName = "";
  String areaName = "";
  Cart(this.storeName, this.areaName, {super.key});

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
            const SizedBox(
              height: 24,
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
                        onPressed: () {},
                        child: const Text(
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
              color: const Color(0xFFAAC4FF),
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeName,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      areaName,
                      style: const TextStyle(
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
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              height: 100,
              color: const Color(0xFFAAC4FF),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  margin: const EdgeInsets.only(left: 170, top: 50),
                  child: const Text(
                    "0원",
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
            ElevatedButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  minimumSize: const Size(400, 50),
                  backgroundColor: const Color(0xFFB1B2FF),
                  side: const BorderSide(
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
                child: const Text(
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
