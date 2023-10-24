import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

final _authentication = FirebaseAuth.instance;

CollectionReference product = FirebaseFirestore.instance.collection('login');
CollectionReference product1 =
    FirebaseFirestore.instance.collection('userinfo');

final TextEditingController idController = TextEditingController();
final TextEditingController pwController = TextEditingController();
final TextEditingController emailController = TextEditingController();

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'jalnan'),
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Color(0xFFAAC4FF),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 120,
                          ),
                          const Text(
                            "회원가입",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          margin: const EdgeInsets.only(left: 15),
                          child: const Text(
                            "이름",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          width: 280,
                          height: 40,
                          margin: const EdgeInsets.only(left: 10),
                          child: TextField(
                            controller: idController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          margin: const EdgeInsets.only(left: 15),
                          child: const Text(
                            "이메일",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          width: 280,
                          height: 40,
                          margin: const EdgeInsets.only(left: 10),
                          child: TextField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'E-mail',
                              hintStyle: TextStyle(
                                  color: Colors.grey[300],
                                  fontStyle: FontStyle.italic),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black12),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black12),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          margin: const EdgeInsets.only(left: 15),
                          child: const Text(
                            "비밀번호",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          width: 280,
                          height: 40,
                          margin: const EdgeInsets.only(left: 10),
                          child: TextField(
                            obscureText: true,
                            controller: pwController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 70,
                        ),
                        Container(
                          width: 280,
                          height: 40,
                          margin: const EdgeInsets.only(left: 15),
                          child: TextField(
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: "비밀번호 확인*",
                                hintStyle: TextStyle(
                                    color: Colors.grey[300],
                                    fontStyle: FontStyle.italic),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          margin: const EdgeInsets.only(left: 15),
                          child: const Text(
                            "휴대전화",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 55,
                          height: 40,
                          margin: const EdgeInsets.only(left: 10),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: "010",
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 13),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                )),
                          ),
                        ),
                        Container(
                          width: 65,
                          height: 40,
                          margin: const EdgeInsets.only(left: 5),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: "0000",
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 13),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                )),
                          ),
                        ),
                        Container(
                          width: 65,
                          height: 40,
                          margin: const EdgeInsets.only(left: 5),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: "0000",
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 13),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                )),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                minimumSize: const Size(60, 40),
                                backgroundColor: const Color(0xFFB1B2FF),
                                shadowColor: Colors.black,
                                elevation: 3,
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 153, 154, 221),
                                  width: 2,
                                )),
                            child: const Text(
                              "인증요청",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 85,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          padding: const EdgeInsets.only(left: 2, right: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB1B2FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "인증번호 입력",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Container(
                          width: 210,
                          height: 40,
                          margin: const EdgeInsets.only(left: 2),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                isDense: true,
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 15),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Builder(
                      builder: (BuildContext context) {
                        return ElevatedButton(
                          onPressed: () async {
                            try {
                              final newUser = await _authentication
                                  .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: pwController.text,
                              );
                              if (newUser.user != null) {
                                product1.add({
                                  'name': idController.text,
                                  'email': emailController.text,
                                  'password': pwController.text,
                                  'userUid': newUser.user!.uid,
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Login();
                                    },
                                  ),
                                );
                                idController.dispose();
                                pwController.dispose();
                                emailController.dispose();
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(300, 40),
                            backgroundColor: const Color(0xFFEEF1FF),
                            shadowColor: Colors.black,
                            elevation: 3,
                            side: const BorderSide(
                              color: Colors.black38,
                              width: 2,
                            ),
                          ),
                          child: const Text(
                            "가입하기",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
