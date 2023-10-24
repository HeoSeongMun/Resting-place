import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoEditScreen extends StatefulWidget {
  UserInfoEditScreen(this.name, this.useremail, {super.key});
  String useremail = "";
  String name = "";
  @override
  _UserInfoEditScreen createState() => _UserInfoEditScreen();
}

class _UserInfoEditScreen extends State<UserInfoEditScreen> {
  final _authentication = FirebaseAuth.instance;

  late TextEditingController nameController =
      TextEditingController(text: widget.name);
  late TextEditingController emailController =
      TextEditingController(text: widget.useremail);
  final TextEditingController pwController1 = TextEditingController();
  final TextEditingController pwController2 = TextEditingController();

  CollectionReference product =
      FirebaseFirestore.instance.collection('userinfo');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'jalnan'),
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('사용자 정보 수정'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 280,
                      height: 40,
                      margin: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.grey[300],
                              fontStyle: FontStyle.italic,
                            ),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 280,
                      height: 40,
                      margin: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[350],
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black12),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black12),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          ),
                        ),
                        enabled: false,
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 280,
                      height: 40,
                      margin: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: pwController1,
                        obscureText: true,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black12),
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
                        controller: pwController2,
                        obscureText: true,
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "비밀번호 확인*",
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
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
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "010",
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 15),
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
                            )),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 40,
                      margin: const EdgeInsets.only(left: 5),
                      child: TextField(
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "0000",
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 15),
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
                            )),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 40,
                      margin: const EdgeInsets.only(left: 5),
                      child: TextField(
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "0000",
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 15),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 210,
                      height: 40,
                      margin: const EdgeInsets.only(left: 2),
                      child: TextField(
                        decoration: InputDecoration(
                            isDense: true,
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 15),
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
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      User? user = _authentication.currentUser;
                      if (user != null) {
                        if (nameController.text != "") {
                          if (pwController1.text != "" &&
                              pwController2.text != "" &&
                              pwController1.text == pwController2.text) {
                            user.updatePassword(pwController2.text);
                            Query query =
                                product.where('userUid', isEqualTo: user.uid);
                            QuerySnapshot querySnapshot = await query.get();
                            final docsId = querySnapshot.docs[0].id;
                            product.doc(docsId).update({
                              'name': nameController.text,
                              'password': pwController2.text,
                            });
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    '변경되었습니다.',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          //onWillpop에 false 전달되어 앱이 종료되지 않는다.
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('확인')),
                                  ],
                                );
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('이름과 비밀번호를 다시 확인해주세요'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('이름과 비밀번호를 다시 확인해주세요'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        }
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
                      "저장",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
