import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/signup.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login extends StatelessWidget {
  Login({super.key});

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

  final emailFocusNode = FocusNode();
  final pwFocusNode = FocusNode();

  final TextEditingController pwController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  CollectionReference product = FirebaseFirestore.instance.collection('login');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'jalnan'),
      home: Scaffold(
        backgroundColor: const Color(0xFFAAC4FF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFAAC4FF),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          automaticallyImplyLeading: true,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 85),
                  child: const Text(
                    '휴잇',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 60, bottom: 20),
                  child: Image.asset(
                    'assets/images/appicon.png',
                    height: 230,
                    width: 250,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  height: 363,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Container(
                          alignment: const Alignment(0.0, 0.0),
                          height: 45,
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 15),
                          child: Container(
                            child: TextField(
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  isDense: true,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  hintText: 'E-mail',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[300],
                                      fontStyle: FontStyle.italic)),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          alignment: const Alignment(0.0, 0.0),
                          height: 45,
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 30, bottom: 50),
                          child: Container(
                              child: TextField(
                            controller: pwController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: Colors.grey[300],
                                    fontStyle: FontStyle.italic)),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          )),
                        ),
                      ),
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
                                    return const Home();
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
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: const Color(0xFFB1B2FF),
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 8, bottom: 8),
                            shadowColor: Colors.black,
                            elevation: 7,
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            )),
                        child: const Text(
                          "로그인",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                          child: Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    ),
                                    child: const Text(
                                      '아이디 찾기',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Text(' | '),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    ),
                                    child: const Text(
                                      '비밀번호 찾기',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Text(' | '),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Signup()),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    ),
                                    child: const Text(
                                      '회원가입',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              )))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
