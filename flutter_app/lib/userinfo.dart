import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/cart.dart';
import 'package:flutter_app/delivery.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/orderedlist.dart';
import 'package:flutter_app/rev_mng.dart';
import 'package:flutter_app/edit_userinf.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/home.dart';

class UserPage extends StatefulWidget {
  UserPage({super.key});

  String useremail = "";
  String username = "";
  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  CollectionReference cartcollection =
      FirebaseFirestore.instance.collection('shoppingBasket');
  final user = FirebaseAuth.instance.currentUser;

  CollectionReference product =
      FirebaseFirestore.instance.collection('userinfo');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'jalnan'),
      home: Scaffold(
        backgroundColor: const Color(0xFFEEF1FF),
        body: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 170),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 2),
                        width: 350,
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      Positioned(
                        top: -50,
                        left: 80,
                        right: 80,
                        child: SizedBox(
                          width: 50,
                          height: 80,
                          child: Image.asset(
                            'assets/images/appicon.png',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Container(
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('userinfo')
                                    .where("email", isEqualTo: user!.email)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(); // 데이터를 가져오는 중 로딩 표시
                                  }
                                  if (!snapshot.hasData ||
                                      snapshot.data!.docs.isEmpty) {
                                    return Container(); // 데이터가 없는 경우 처리
                                  }
                                  // 데이터가 있는 경우 처리
                                  final DocumentSnapshot documentSnapshot =
                                      snapshot.data!.docs[0];
                                  String name = documentSnapshot[
                                      'name']; // 'name' 필드값 가져오기
                                  String email = documentSnapshot['email'];
                                  widget.useremail = email; // 'email' 필드값 가져오기
                                  String mileage =
                                      documentSnapshot['mileage'].toString();
                                  return Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 255,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserInfoEditScreen(
                                                              name,
                                                              widget
                                                                  .useremail)),
                                                );
                                              },
                                              child: Text(
                                                '수정하기>>',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey[400]),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '이름 : $name',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          height: 10,
                                        ),
                                        Text(
                                          '이메일 : $email',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          height: 10,
                                        ),
                                        Text(
                                          '마일리지 : $mileage',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                width: 360,
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Delivery()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFC5DFF8),
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
                            spreadRadius: 0.5,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      width: 110,
                      height: 110,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('주문상태'),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Image.asset(
                              'assets/images/cooking.png',
                              fit: BoxFit.fill,
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderedList()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFC5DFF8),
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
                            spreadRadius: 0.5,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      width: 110,
                      height: 110,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('주문내역'),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Image.asset(
                              'assets/images/bill.png',
                              fit: BoxFit.fill,
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ReviewManagementScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFC5DFF8),
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
                            spreadRadius: 0.5,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      width: 110,
                      height: 110,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('리뷰관리'),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Image.asset(
                              'assets/images/reviews.png',
                              fit: BoxFit.fill,
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 200),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffAAC4FF),
                ),
                child: const Text(
                  '로그아웃',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              elevation: 20,
              currentIndex: 4,
              onTap: (int index) async {
                switch (index) {
                  case 0: //검색
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AreaSearch()),
                    );
                    break;
                  case 1: //장바구니
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Cart()),
                    );
                    break;
                  case 2: //홈
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                      (route) => false,
                    );
                    break;
                  case 3: //주문내역
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderedList()),
                    );
                    break;
                  case 4: //마이휴잇
                    setState(() {});
                    break;
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Stack(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 10,
                        ),
                        child: Icon(Icons.search),
                      ),
                      Positioned(
                        top: 0,
                        right: 3,
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                  label: '검색',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 10,
                        ),
                        child: Icon(Icons.shopping_cart_outlined),
                      ),
                      Positioned(
                        top: 0,
                        right: 3,
                        child: StreamBuilder(
                          stream: cartcollection
                              .where('userUid', isEqualTo: user!.uid)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot streamSnapshot) {
                            if (!streamSnapshot.hasData ||
                                streamSnapshot.data!.docs.isEmpty) {
                              return Container(); // 데이터가 없는 경우 처리
                            }
                            if (streamSnapshot.hasError) {
                              debugPrint('에러');
                              Container();
                            }
                            if (streamSnapshot.hasData) {
                              int count = streamSnapshot.data!.docs.length;
                              return Container(
                                  alignment: Alignment.center,
                                  width: 15,
                                  height: 15,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(count.toString()));
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      )
                    ],
                  ),
                  label: '장바구니',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 10,
                        ),
                        child: Icon(Icons.home_outlined),
                      ),
                      Positioned(
                        top: 0,
                        right: 3,
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 10,
                        ),
                        child: Icon(Icons.receipt_long_outlined),
                      ),
                      Positioned(
                        top: 0,
                        right: 3,
                        child: StreamBuilder(
                          stream: ordercollection
                              .where('userUid', isEqualTo: user!.uid)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot streamSnapshot) {
                            if (!streamSnapshot.hasData ||
                                streamSnapshot.data!.docs.isEmpty) {
                              return Container(); // 데이터가 없는 경우 처리
                            }
                            if (streamSnapshot.hasError) {
                              debugPrint('에러');
                              Container();
                            }
                            if (streamSnapshot.hasData) {
                              int count = streamSnapshot.data!.docs.length;
                              return Container(
                                  alignment: Alignment.center,
                                  width: 15,
                                  height: 15,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(count.toString()));
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      )
                    ],
                  ),
                  label: '주문내역',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 10,
                        ),
                        child: Icon(Icons.face),
                      ),
                      Positioned(
                        top: 0,
                        right: 3,
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                  label: '마이휴잇',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
