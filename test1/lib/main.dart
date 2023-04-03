import 'package:flutter/material.dart';
import 'signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFAAC4FF),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAAC4FF),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        leading:
          IconButton(
            icon: const Icon(Icons.close),
              tooltip: 'Next page',
              onPressed: () {
              },
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 25),
              child: Text('휴게소에서 뭐먹지?',
              style: TextStyle(
                fontFamily: 'pretendard',
                fontSize : 35,
                fontWeight : FontWeight.bold,
              ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Image.asset('assets/images/1.png',height: 230, width: 250,),
            ),
            Container(
              alignment: Alignment.center,
              height: 333,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight:Radius.circular(40)
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      child: Container(
                        alignment: Alignment(0.0, 0.0),
                        height: 45,
                        margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                        child: Container(
                          child:TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                                hintText: 'ID',
                                hintStyle: TextStyle(color: Colors.grey[300],fontStyle: FontStyle.italic)
                            ),
                          ),
                        ),
                     ),
                  ),
                  Container(
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 50),
                      child: Container(
                          child:TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey[300], fontStyle: FontStyle.italic)
                            ),
                          )
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Color(0xFFB1B2FF),
                        padding: EdgeInsets.only(left: 30,right: 30, top: 8, bottom: 8),
                        shadowColor: Colors.black,
                        elevation: 7,
                        side: BorderSide(
                          color: Colors.black,
                          width: 1.5,
                        )
                      ),
                      child: Text("로그인",
                      style: TextStyle(
                        fontSize : 20,
                        fontWeight : FontWeight.bold,
                      ),
                      ),
                  ),
                  Flexible(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                child: Text('아이디 찾기',
                                  style: TextStyle(
                                    fontSize : 15,
                                    fontWeight : FontWeight.bold,
                                  ),
                                ),
                            ),
                            Text(' | '),
                            TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                child: Text('비밀번호 찾기',
                                  style: TextStyle(
                                    fontSize : 15,
                                    fontWeight : FontWeight.bold,
                                  ),
                                ),
                            ),
                            Text(' | '),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => signup()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                child: Text('회원가입',
                                  style: TextStyle(
                                    fontSize : 15,
                                    fontWeight : FontWeight.bold,
                                  ),
                                ),
                            ),
                          ],
                        )
                      )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}