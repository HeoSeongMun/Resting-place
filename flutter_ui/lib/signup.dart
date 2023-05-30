import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/login.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final _authentication = FirebaseAuth.instance;

  // 텍스트 폼 필드 테스트 (이건 지워도됨)
  String userId = "";
  String userPw = "";

  CollectionReference product =
      FirebaseFirestore.instance.collection('testlogin');

  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController directionController = TextEditingController();
  final TextEditingController storenameController = TextEditingController();
  final TextEditingController restareanameController = TextEditingController();

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
                      controller: idController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '닉네임',
                      ),
                    ),
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '비밀번호',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: restareanameController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                              r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '휴게소 이름을 적어주세요',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: directionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '어느 방향 고속도로인지 적어주세요 예)서울방향, 부산방향',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: storenameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '가게 이름을 적어주세요',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              final newUser = await _authentication
                                  .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: pwController.text,
                              );

                              await FirebaseFirestore.instance
                                  .collection('testlogin')
                                  .doc(newUser.user!.uid)
                                  .set(
                                {
                                  'userId': idController.text,
                                  'email': emailController.text,
                                  'restAreaName': restareanameController.text,
                                  'direction': directionController.text,
                                  'storeName': storenameController.text,
                                },
                              );

                              if (newUser.user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Login();
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
                          },
                          child: const Text('회원가입'),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: const Text('로그인 페이지'),
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
