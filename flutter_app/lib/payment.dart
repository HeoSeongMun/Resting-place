import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'completepayment.dart';

class Payment extends StatelessWidget {
  Payment(this.total, {super.key});

  String name = '';
  String price = '';
  String storeName = '';
  String location = '';
  String storeUid = '';
  String userUid = '';
  String total = '';

  CollectionReference SBproduct =
      FirebaseFirestore.instance.collection('shoppingBasket');

  CollectionReference order = FirebaseFirestore.instance.collection('order');

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Container(
              height: 50,
              color: const Color.fromARGB(255, 255, 255, 255),
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
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 1.3,
              width: 390,
              color: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 40, right: 15),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: const [
                      Text(
                        "주문금액",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 230,
                  ),
                  Column(
                    children: [
                      Text(
                        '$total원',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 1.5,
              width: 390,
              color: Colors.black26,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "총 할인금액",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "0원",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration: const BoxDecoration(
                color: Color(0xFFD2DAFF),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "내 마일리지",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      "0원",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 130),
                      width: 50,
                      height: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          backgroundColor: const Color(0xFFEEF1FF),
                          side: const BorderSide(
                            color: Color(0xFFEEF1FF),
                            width: 1,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "사용",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 1.5,
              width: 390,
              color: Colors.black26,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration: const BoxDecoration(
                color: Color(0xFFD2DAFF),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "결제 금액",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$total원',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 1.8,
              width: 390,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 25, top: 10, bottom: 20),
              child: const Text(
                "결제 수단",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              height: 130,
              child: IconButton(
                onPressed: () {
                  debugPrint("터치");
                },
                icon: Image.asset(
                  'assets/images/kakaopay.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 119,
                      height: double.infinity,
                      color: Colors.grey,
                      child: const Text(
                        "취소",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Query query =
                          SBproduct.where('userUid', isEqualTo: user!.uid);
                      QuerySnapshot querySnapshot = await query.get();
                      List<QueryDocumentSnapshot> documents =
                          querySnapshot.docs;
                      for (QueryDocumentSnapshot document in documents) {
                        // 'name', 'price', 'storeName' 필드 값 가져오기
                        name = document.get('name');
                        price = document.get('price');
                        storeName = document.get('storeName');
                        storeUid = document.get('storeUid');
                        userUid = document.get('userUid');
                      }
                      await order.add({
                        'name': name,
                        'price': price,
                        'storeName': storeName,
                        'storeUid': storeUid,
                        'userUid': userUid,
                      });

                      //유저 uid 비교해서 해당하는 문서 삭제

                      for (QueryDocumentSnapshot document in documents) {
                        await document.reference.delete();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PayComplete(total)),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 292.3,
                      height: double.infinity,
                      color: const Color(0xFFB1B2FF),
                      child: const Text(
                        "결제",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
