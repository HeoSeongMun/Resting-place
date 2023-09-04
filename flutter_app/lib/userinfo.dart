import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 110),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserInfoEditScreen(useremail)),
                        );
                      },
                      child: Container(
                        width: 362,
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage:
                                      AssetImage('assets/images/appicon.png'),
                                ),
                              ),
                              SizedBox(width: 50),
                              Container(
                                width: 150,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 200,
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('userinfo')
                                            .where("email",
                                                isEqualTo: user!.email)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator(); // 데이터를 가져오는 중 로딩 표시
                                          }
                                          if (!snapshot.hasData ||
                                              snapshot.data!.docs.isEmpty) {
                                            return Container(); // 데이터가 없는 경우 처리
                                          }
                                          // 데이터가 있는 경우 처리
                                          final DocumentSnapshot
                                              documentSnapshot =
                                              snapshot.data!.docs[0];
                                          String name = documentSnapshot[
                                              'name']; // 'name' 필드값 가져오기
                                          String email =
                                              documentSnapshot['email'];
                                          useremail = email; // 'email' 필드값 가져오기
                                          return Text(
                                            textAlign: TextAlign.center,
                                            name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 200,
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('userinfo')
                                            .where("email",
                                                isEqualTo: user!.email)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator(); // 데이터를 가져오는 중 로딩 표시
                                          }
                                          if (!snapshot.hasData ||
                                              snapshot.data!.docs.isEmpty) {
                                            return Container(); // 데이터가 없는 경우 처리
                                          }
                                          // 데이터가 있는 경우 처리
                                          final DocumentSnapshot
                                              documentSnapshot =
                                              snapshot.data!.docs[0];
                                          String name = documentSnapshot[
                                              'name']; // 'name' 필드값 가져오기
                                          String email = documentSnapshot[
                                              'email']; // 'email' 필드값 가져오기
                                          return Text(
                                            textAlign: TextAlign.center,
                                            email,
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Text(
                                      '보유 마일리지\nn원',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              )
                            ]),
                      )),
                ],
              )),
          SizedBox(height: 30),
          Container(
            width: 360,
            height: 2,
            color: Colors.black,
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderedList()),
                    );
                  },
                  child: Container(
                    width: 360,
                    height: 100,
                    color: Color(0xffAAC4FF),
                    child: Text('주문내역'),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewManagementScreen()),
                    );
                  },
                  child: Container(
                    width: 360,
                    height: 100,
                    color: Color(0xffAAC4FF),
                    child: Text('리뷰 관리'),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 40),
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
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(Icons.home),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }),
            IconButton(
              icon: Icon(
                Icons.man,
              ),
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AreaSearch()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
