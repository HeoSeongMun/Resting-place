import 'package:flutter/material.dart';

class PayComplete extends StatelessWidget {
  PayComplete({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                //color: Colors.red,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 15),
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/cashback.png',
                  width: 100,
                  height: 100,
                ),
              ),
              Container(
                //color: Colors.red,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 15),
                width: 350,
                child: Text(
                  "총 n원이 마일리지로",
                  style: TextStyle(
                    fontSize: 20.0, // 글자 크기
                    fontWeight: FontWeight.bold, // 볼드체
                    color: Colors.black, // 색상
                    letterSpacing: 3.0,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                //color: Colors.red,
                child: Text(
                  "적립되었습니다!",
                  style: TextStyle(
                    fontSize: 20.0, // 글자 크기
                    fontWeight: FontWeight.bold, // 볼드체
                    color: Colors.black, // 색상
                    letterSpacing: 3.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                color: Colors.black,
                height: 5,
                width: 340,
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 15),
                  //color: Colors.red,
                  width: 340,
                  child: Text("결제정보",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ))),
              Container(
                margin: EdgeInsets.only(top: 10),
                color: Colors.black26,
                height: 2,
                width: 340,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 340,
                child: Text(
                  "요청금액",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 3),
                  width: 340,
                  child: Text("주문금액",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ))),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 40),
                  color: Color(0xffD2DAFF),
                  height: 40,
                  width: 340,
                  child: Text("  총 마일리지 할인 금액",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ))),
              Container(
                  alignment: Alignment.bottomRight,
                  color: Color(0xffD2DAFF),
                  height: 20,
                  width: 340,
                  child: Text("n원  ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ))),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 30),
                  //color: Colors.red,
                  width: 340,
                  child: Text("결제 금액",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ))),
              Container(
                margin: EdgeInsets.only(top: 10),
                color: Colors.black26,
                height: 2,
                width: 340,
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 20),
                  //color: Colors.red,
                  width: 340,
                  child: Text("최종 결제 금액",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ))),
              Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 5),
                  //color: Colors.red,
                  width: 340,
                  child: Text("n원",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ))),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 30),
                color: Color(0xffB1B2FF),
                height: 68.4,
                child: Text("확인",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
