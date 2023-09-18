import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/signup.dart';

class UserInfoEditScreen extends StatelessWidget {
  UserInfoEditScreen(this.name, this.useremail, {super.key});
  String useremail = "";
  String name = "";
  final _authentication = FirebaseAuth.instance;

  late TextEditingController nameController = TextEditingController(text: name);
  late TextEditingController emailController =
      TextEditingController(text: useremail);
  final TextEditingController pwController1 = TextEditingController();
  final TextEditingController pwController2 = TextEditingController();

  CollectionReference product =
      FirebaseFirestore.instance.collection('userinfo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('사용자 정보 수정'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Container(
                    width: 60,
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "이름",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 280,
                    height: 40,
                    margin: EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey[300],
                            fontStyle: FontStyle.italic,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: 60,
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "이메일",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 280,
                    height: 40,
                    margin: EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[350],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                      ),
                      enabled: false,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: 60,
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "비밀번호",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 280,
                    height: 40,
                    margin: EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: pwController1,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 70,
                  ),
                  Container(
                    width: 280,
                    height: 40,
                    margin: EdgeInsets.only(left: 15),
                    child: TextField(
                      controller: pwController2,
                      obscureText: true,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "비밀번호 확인*",
                          hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontStyle: FontStyle.italic),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    width: 60,
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "휴대전화",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 55,
                    height: 40,
                    margin: EdgeInsets.only(left: 10),
                    child: TextField(
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "010",
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          )),
                    ),
                  ),
                  Container(
                    width: 65,
                    height: 40,
                    margin: EdgeInsets.only(left: 5),
                    child: TextField(
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "0000",
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          )),
                    ),
                  ),
                  Container(
                    width: 65,
                    height: 40,
                    margin: EdgeInsets.only(left: 5),
                    child: TextField(
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "0000",
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          minimumSize: Size(60, 40),
                          primary: Colors.black,
                          backgroundColor: Color(0xFFB1B2FF),
                          shadowColor: Colors.black,
                          elevation: 3,
                          side: BorderSide(
                            color: Color.fromARGB(255, 153, 154, 221),
                            width: 2,
                          )),
                      child: Text(
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
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 85,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    padding: EdgeInsets.only(left: 2, right: 2),
                    decoration: BoxDecoration(
                      color: Color(0xFFB1B2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
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
                    margin: EdgeInsets.only(left: 2),
                    child: TextField(
                      decoration: InputDecoration(
                          isDense: true,
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  User? _user = _authentication.currentUser;
                  if (_user != null) {
                    if (nameController.text != "") {
                      if (pwController1.text != "" &&
                          pwController2.text != "" &&
                          pwController1.text == pwController2.text) {
                        _user.updatePassword(pwController2.text);
                        Query query =
                            product.where('userUid', isEqualTo: _user.uid);
                        QuerySnapshot querySnapshot = await query.get();
                        final docs_id = querySnapshot.docs[0].id;
                        product.doc('${docs_id}').update({
                          'name': nameController.text,
                          'password': pwController2.text,
                        });
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
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
                                        Navigator.pop(context, false);
                                      },
                                      child: Text('확인')),
                                ],
                              );
                            });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('이름과 비밀번호를 다시 확인해주세요'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      }
                    }
                  }
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(300, 40),
                  primary: Colors.black,
                  backgroundColor: Color(0xFFEEF1FF),
                  shadowColor: Colors.black,
                  elevation: 3,
                  side: BorderSide(
                    color: Colors.black38,
                    width: 2,
                  ),
                ),
                child: Text(
                  "저장",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
