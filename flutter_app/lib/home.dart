import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/userinfo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  Future<bool> _onBackKey() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff161619),
            title: Text(
              '앱을 종료하시겠습니까??',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    //onWillpop에 false 전달되어 앱이 종료되지 않는다.
                    Navigator.pop(context, false);
                  },
                  child: Text('아니오')),
              TextButton(
                  onPressed: () {
                    //onWillpop에 true가 전달되어 앱이 종료 된다.
                    SystemNavigator.pop(); // 앱 종료
                  },
                  child: Text('예')),
            ],
          );
        });
  }

  final CarouselController _controller = CarouselController();
  final imageList = [
    Image.asset('assets/images/1.png', fit: BoxFit.contain),
    Image.asset('assets/images/2.jpg', fit: BoxFit.contain),
    Image.asset('assets/images/3.png', fit: BoxFit.contain),
    Image.asset('assets/images/4.jpg', fit: BoxFit.contain),
    Image.asset('assets/images/5.jpg', fit: BoxFit.contain),
  ];
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackKey,
      child: MaterialApp(
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
                height: 10,
              ),
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  height: 150.0,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 0.45, // 화면 비율
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: imageList.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: image,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent
                              .withOpacity(_current == entry.key ? 0.9 : 0.4),
                        ),
                      ),
                    );
                  }).toList(),
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
      ),
    );
  }
}
