import 'package:flutter/material.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/userinfo.dart';

class Home extends StatelessWidget {
  Home({super.key});
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 15),
              child: Text(
                "최근 주문 휴게소",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                height: 40,
                color: Color(0xFFAAC4FF),
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    "오늘 뭐먹지??",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              height: 80,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 40, right: 10, top: 10, bottom: 10),
                      width: 80,
                      height: 40,
                      color: Colors.deepOrange,
                    ),
                  ),
                  Text(
                    "는 어떨까요??",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 90),
                    child: ElevatedButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          primary: Colors.black,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 19, right: 10),
                          maximumSize: Size(65, 70),
                          backgroundColor: Color(0xFFD2DAFF),
                          side: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "결과 보기",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              color: Color(0xFFAAC4FF),
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  "이벤트 / 광고",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey,
              height: 100,
              child: Text("배너1"),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey,
              height: 100,
              child: Text("배너2"),
            ),
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
                  onPressed: () {}),
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
      ),
    );
  }
}
