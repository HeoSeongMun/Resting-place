import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              height: 50,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0, right: 0),
                    width: 60,
                    height: 60,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 35,
                      color: Color.fromARGB(255, 0, 0, 0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 1.3,
              width: 360,
              color: Colors.black,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "요청 금액",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "주문금액",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 230,
                  ),
                  Column(
                    children: [
                      Text(
                        "0원",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "0원",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 1.5,
              width: 360,
              color: Colors.black26,
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "총 할인금액",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "0원",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 70,
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: Color(0xFFD2DAFF),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "내 마일리지",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "0원",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 130),
                      width: 50,
                      height: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          primary: Colors.black,
                          backgroundColor: Color(0xFFEEF1FF),
                          side: BorderSide(
                            color: Color(0xFFEEF1FF),
                            width: 1,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "사용",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 1.5,
              width: 360,
              color: Colors.black26,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: Color(0xFFD2DAFF),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 1.8,
              width: 360,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 25),
              child: Text(
                "결제 수단",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 130,
              child: IconButton(
                onPressed: () {
                  debugPrint("터치");
                },
                icon: Image.asset(
                  'assets/images/kakaopay.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: double.infinity,
                      color: Colors.grey,
                      child: Text(
                        "취소",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      debugPrint("결제");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 292.3,
                      height: double.infinity,
                      color: Color(0xFFB1B2FF),
                      child: Text(
                        "결제",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
