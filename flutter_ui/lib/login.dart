import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ui/mainpage.dart';
import 'package:flutter_ui/signup.dart';

class Login extends StatelessWidget {
  Login({super.key});

  //현제 사용자 정보 가져오기
  final _authentication = FirebaseAuth.instance;

  User? loggedUser;

  void initState() {
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // 텍스트 폼 필드 테스트
  String userId = "";
  String userPw = "";

  CollectionReference product =
      FirebaseFirestore.instance.collection('testlogin');

  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // 테스트
  Future<void> update(DocumentSnapshot documentSnapshot) async {
    idController.text = documentSnapshot['name'];
    pwController.text = documentSnapshot['price'];
  }

  // 테스트
  Future<void> create() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '이메일',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      controller: pwController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '비밀번호',
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signup(),
                              ),
                            );
                          },
                          child: const Text('회원가입페이지'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              final newUser = await _authentication
                                  .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: pwController.text,
                              );
                              if (newUser.user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MainPage();
                                    },
                                  ),
                                );
                              }
                            } catch (e) {
                              print(e);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('이메일과 비밀번호를 확인해주세요'),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                            }
                            /*final String id = idController.text;
                            final String pw = pwController.text;*/
                          },
                          child: const Text('로그인'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
