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

class UserPage extends StatelessWidget {
  UserPage({super.key});

  String useremail = "";
  String username = "";

  final user = FirebaseAuth.instance.currentUser;

  CollectionReference product =
      FirebaseFirestore.instance.collection('userinfo');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'jalnan'),
      home: Scaffold(
        backgroundColor: Color(0xFFEEF1FF),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 170),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 2),
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
                        child: Container(
                          width: 50,
                          height: 80,
                          child: Image.asset(
                            'assets/images/appicon.png',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
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
                                  useremail = email; // 'email' 필드값 가져오기
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
                                                              name, useremail)),
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
                                          '이름 : ' + name,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          height: 10,
                                        ),
                                        Text(
                                          '이메일 : ' + email,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          height: 10,
                                        ),
                                        Text(
                                          '마일리지 : ' + mileage,
                                          style: TextStyle(
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
              SizedBox(height: 50),
              Container(
                width: 360,
                height: 2,
                color: Colors.black,
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Delivery()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFC5DFF8),
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
                            spreadRadius: 0.5,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      width: 110,
                      height: 110,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text('배송조회'),
                          SizedBox(
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderedList()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFC5DFF8),
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
                            spreadRadius: 0.5,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      width: 110,
                      height: 110,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text('주문내역'),
                          SizedBox(
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
                            builder: (context) => ReviewManagementScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFC5DFF8),
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
                            spreadRadius: 0.5,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      width: 110,
                      height: 110,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text('리뷰관리'),
                          SizedBox(
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
              SizedBox(height: 200),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffAAC4FF),
                ),
                child: Text(
                  '로그아웃',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 20,
            currentIndex: 4,
            onTap: (int index) {
              switch (index) {
                case 0: //검색
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AreaSearch()),
                  );
                  break;
                case 1: //장바구니
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
                  );
                  break;
                case 2: //홈
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                  break;
                case 3: //주문내역
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderedList()),
                  );
                  break;
                case 4: //마이휴잇
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '검색',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: '장바구니',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                label: '주문내역',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.face),
                label: '마이휴잇',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
