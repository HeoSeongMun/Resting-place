import 'package:flutter/material.dart';

class signup extends StatelessWidget{

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFFAAC4FF),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Text("회원가입",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Container(
                  width: 60,
                  margin: EdgeInsets.only(left: 15),
                  child:
                  Text("이름",
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
                  child:
                  TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide: BorderSide(width:2,
                                color: Colors.black12),
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        borderSide: BorderSide(width:2,
                            color: Colors.black12),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                      )
                    ),
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
                  child:
                  Text("아이디",
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
                  child:
                  TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        )
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child:
                  ElevatedButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        minimumSize: Size(20, 30),
                        primary: Colors.black,
                        backgroundColor: Color(0xFFB1B2FF),
                        shadowColor: Colors.black,
                        elevation: 3,
                        side: BorderSide(
                          color: Color(0xFFB1B2FF),
                        )
                    ),
                    child: Text("중복확인",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  width: 60,
                  margin: EdgeInsets.only(left: 15),
                  child:
                  Text("비밀번호",
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
                  child:
                  TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        )
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
                  width: 70,
                ),
                Container(
                  width: 280,
                  height: 40,
                  margin: EdgeInsets.only(left: 15),
                  child:
                  TextField(
                    decoration: InputDecoration(
                      isDense: true,
                        hintText: "비밀번호 확인*",
                        hintStyle: TextStyle(color: Colors.grey[400],fontStyle: FontStyle.italic),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        )
                    ),
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
                  child:
                  Text("휴대전화",
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
                  child:
                  TextField(
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: "010",
                        hintStyle: TextStyle(color: Colors.grey[400],fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        )
                    ),
                  ),
                ),
                Container(
                  width: 65,
                  height: 40,
                  margin: EdgeInsets.only(left: 5),
                  child:
                  TextField(
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: "0000",
                        hintStyle: TextStyle(color: Colors.grey[400],fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        )
                    ),
                  ),
                ),
                Container(
                  width: 65,
                  height: 40,
                  margin: EdgeInsets.only(left: 5),
                  child:
                  TextField(
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: "0000",
                        hintStyle: TextStyle(color: Colors.grey[400],fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child:
                  ElevatedButton(
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
                          color: Color(0xFFB1B2FF),
                        )
                    ),
                    child: Text("인증번호 전송",
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
              height: 30,
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
                  child:
                  Text("인증번호 입력",
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
                  child:
                  TextField(
                    decoration: InputDecoration(
                        isDense: true,
                        hintStyle: TextStyle(color: Colors.grey[400],fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          borderSide: BorderSide(width:2,
                              color: Colors.black12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        )
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
                onPressed: null,
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
                child: Text("가입하기",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  ),
                ),
            ),
          ],
        )
      ),
    );
  }
}