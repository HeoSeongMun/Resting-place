import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';

class PayComplete extends StatelessWidget {
  PayComplete(this.total, {super.key});
  String total = '';

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
                margin: EdgeInsets.only(top: 50),
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/images/cashback.png',
                  width: 150,
                  height: 150,
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
                  margin: EdgeInsets.only(top: 40),
                  //color: Colors.red,
                  width: 340,
                  child: Text("결제정보",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ))),
              Container(
                margin: EdgeInsets.only(top: 20),
                color: Colors.black26,
                height: 2,
                width: 340,
              ),
              Container(
                width: 340,
                margin: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 40,
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "주문금액",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 180,
                    ),
                    Column(
                      children: [
                        Text(
                          total + '원',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: 340,
                margin: EdgeInsets.only(top: 40),
                color: Color(0xffD2DAFF),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 10, top: 15),
                        child: const Text(
                          "총 마일리지 할인 금액",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 70, right: 15),
                        child: const Text(
                          "n원",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ]),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 50),
                  //color: Colors.red,
                  width: 340,
                  child: Text("결제 금액",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ))),
              Container(
                margin: EdgeInsets.only(top: 15),
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
                  margin: EdgeInsets.only(top: 30, bottom: 35),
                  //color: Colors.red,
                  width: 340,
                  child: Text("n원",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ))),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    color: Color(0xffB1B2FF),
                    child: const Text(
                      "확인",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
