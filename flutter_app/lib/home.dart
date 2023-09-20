import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/cart.dart';
import 'package:flutter_app/orderedlist.dart';
import 'package:flutter_app/restaurant.dart';
import 'package:flutter_app/userinfo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  CollectionReference areacollection =
      FirebaseFirestore.instance.collection('area');
  CollectionReference menucollection =
      FirebaseFirestore.instance.collection('menu');
  final user = FirebaseAuth.instance.currentUser;
  final CarouselController _controller = CarouselController();
  int _current = 0; // CarouselController 첫 인덱스
  int slotindex = 0;
  bool isSpinning = false;
  final Random random = Random();

  List<String> imageurlData = [];
  List<String> locationData = [];
  Future<void> imageData() async {
    Set<String> imageurlList = Set<String>();
    QuerySnapshot snapshot = await ordercollection
        .where('userUid', isEqualTo: user!.uid)
        .limit(5)
        .get();
    snapshot.docs.forEach((doc) {
      imageurlList.add(doc['area_name']);
    });

    List<String> imageurlList2 = [];
    List<String> locationList = [];
    QuerySnapshot snapshot1 =
        await areacollection.where('location', whereIn: imageurlList).get();

    snapshot1.docs.forEach((doc) {
      imageurlList2.add(doc['imageUrl']);
      locationList.add(doc['location']);
    });

    setState(() {
      imageurlData = imageurlList2.toList();
      locationData = locationList.toList();
    });
  }

  List<String> slotData = [];
  //슬롯 함수
  Future<List<String>> getItems() async {
    QuerySnapshot querySnapshot = await menucollection.get();
    List<String> items = [];
    querySnapshot.docs.forEach((doc) {
      items.add(doc['name']);
    });
    return items;
  }

  void spinSlotMachine(List<String> items) {
    if (!isSpinning) {
      setState(() {
        isSpinning = true;
      });

      final int spins = random.nextInt(5) + 1; // 1에서 5회 돌림
      int currentSpin = 0;

      void performSpin() {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            slotindex = random.nextInt(items.length);
            currentSpin++;

            if (currentSpin < spins) {
              performSpin();
            } else {
              isSpinning = false;
            }
          });
        });
      }

      performSpin();
    }
  }

  void initState() {
    super.initState();
    imageData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackKey,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'jalnan'),
        home: Scaffold(
          backgroundColor: Color(0xFFEEF1FF), //Color(0xFF92B4EC)
          body: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Color(0xFFC5DFF8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: const Offset(0, 7),
                      ),
                    ]),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 15),
                          child: Text(
                            "최근 주문 휴게소",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        enlargeCenterPage: true, // 무한 스크롤 비활성화
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        viewportFraction: 0.9, // 화면 비율
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: imageurlData.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final String image = entry.value;
                        final String text = locationData[index];
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Restaurant(
                                                locationData[index],
                                                imageurlData[index]),
                                          ),
                                        );
                                      },
                                      child: Image.network(
                                        image.toString(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      text,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageurlData.asMap().entries.map((entry) {
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
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Color(0xFFC5DFF8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: const Offset(0, 7),
                      ),
                    ]),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 15),
                            child: Text(
                              "오늘 뭐먹지??",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: FutureBuilder<List<String>>(
                        future: getItems(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Container();
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            List<String> items = snapshot.data!;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 180,
                                  child: isSpinning
                                      ? AnimatedContainer(
                                          duration: Duration(milliseconds: 100),
                                          child: Text(
                                            items[random.nextInt(items.length)],
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        )
                                      : Text(
                                          items[slotindex],
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2, left: 10),
                                  child: Text(
                                    "어떨까요??",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      primary: Colors.black,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 15,
                                          bottom: 15),
                                      backgroundColor: Color(0xFFFFD577),
                                      side: BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    onPressed: () {
                                      spinSlotMachine(items);
                                    },
                                    child: Text(
                                      "결과\n" + "보기",
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
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
                height: 30,
                color: Colors.white,
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
                child: Image.asset(
                  'assets/images/bu1.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.grey,
                height: 100,
                child: Image.asset(
                  'assets/images/bu2.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                elevation: 20,
                currentIndex: 2,
                onTap: (int index) {
                  switch (index) {
                    case 0: //검색
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AreaSearch()),
                      );
                      break;
                    case 1: //장바구니
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cart()),
                      );
                      break;
                    case 2: //홈
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                      break;
                    case 3: //주문내역
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderedList()),
                      );
                      break;
                    case 4: //마이휴잇
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserPage()),
                      );
                      break;
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: '검색',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: '장바구니',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: '홈',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.receipt_long_outlined),
                    label: '주문내역',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.face),
                    label: '마이휴잇',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //앱 종료 함수
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
}
