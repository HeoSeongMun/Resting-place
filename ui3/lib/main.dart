import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
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
              child:
              Text("최근 주문 휴게소",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              height: 130,
              child:Scrollbar(
                thickness: 4,
                radius: Radius.circular(10),
                isAlwaysShown: true,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      width: 140,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                    ),
                    width: 140,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    width: 140,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    width: 140,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    width: 140,
                  ),
                  ],
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
                child: Text("오늘 뭐먹지??",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              height: 80,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    child: Container(
                      margin: EdgeInsets.only(left: 40, right:10, top: 10,bottom: 10),
                      width: 80,
                      height: 40,
                      color: Colors.deepOrange,
                    ),
                  ),
                  Text("는 어떨까요??",
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
                        padding: EdgeInsets.only(left:19,right: 10),
                        maximumSize: Size(65, 70),
                        backgroundColor: Color(0xFFD2DAFF),
                        side: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                        onPressed: () {},
                        child: Text("결과 보기",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
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
                  child: Text("이벤트 / 광고",
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
              child: Text("배너1"
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey,
              height: 100,
              child: Text("배너2"
              ),
            ),
          ],
        ),
      ),
    );
  }
}
