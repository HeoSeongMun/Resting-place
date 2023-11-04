import 'dart:async';
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

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  CollectionReference completecollection =
      FirebaseFirestore.instance.collection('complete');
  CollectionReference areacollection =
      FirebaseFirestore.instance.collection('area');
  CollectionReference menucollection =
      FirebaseFirestore.instance.collection('menu');
  CollectionReference cartcollection =
      FirebaseFirestore.instance.collection('shoppingBasket');
  final user = FirebaseAuth.instance.currentUser;
  final CarouselController _controller = CarouselController();
  int _current = 0; // CarouselController 첫 인덱스
  int slotindex = 0;
  bool isSpinning = false;

  int cartcount = 0;
  int ordercount = 0;
  final Random random = Random();

  List<String> imageurlData = [];
  List<String> locationData = [];

  Future<void> imageData() async {
    Set<String> imageurlList = <String>{};
    QuerySnapshot snapshot = await ordercollection
        .where('userUid', isEqualTo: user!.uid)
        .limit(5)
        .get();
    for (var doc in snapshot.docs) {
      imageurlList.add(doc['area_name']);
    }

    Set<String> imageurlList2 = <String>{};
    Set<String> locationList = <String>{};
    if (imageurlList.isNotEmpty) {
      QuerySnapshot snapshot1 =
          await areacollection.where('location', whereIn: imageurlList).get();
      for (var doc in snapshot1.docs) {
        imageurlList2.add(doc['imageUrl']);
        locationList.add(doc['location']);
      }
    } else if (imageurlList.isEmpty) {
      QuerySnapshot snapshot = await completecollection
          .where('userUid', isEqualTo: user!.uid)
          .limit(5)
          .get();
      for (var doc in snapshot.docs) {
        imageurlList.add(doc['area_name']);
        if (imageurlList.isNotEmpty) {
          QuerySnapshot snapshot1 = await areacollection
              .where('location', whereIn: imageurlList)
              .get();
          for (var doc in snapshot1.docs) {
            imageurlList2.add(doc['imageUrl']);
            locationList.add(doc['location']);
          }
        }
      }
    }

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
    for (var doc in querySnapshot.docs) {
      items.add(doc['name']);
    }
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
        Future.delayed(const Duration(seconds: 1), () {
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

  late bool isLoading = true;
  @override
  void initState() {
    imageData();
    getItems();
    isLoading = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackKey,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'jalnan'),
        home: Scaffold(
          backgroundColor: const Color(0xFFEEF1FF), //Color(0xFF92B4EC)
          body: isLoading
              ? Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2.5),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset(
                              'assets/images/ingappicon3.gif'), // 로딩 인디케이터
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('...로딩중...')
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 300,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xFFC5DFF8),
                          borderRadius: const BorderRadius.only(
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
                                margin:
                                    const EdgeInsets.only(left: 20, top: 15),
                                child: const Text(
                                  "최근 주문 휴게소",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: InkWell(
                                            onTap: () async {
                                              final result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Restaurant(
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
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 350,
                                          child: Text(
                                            text,
                                            style: const TextStyle(
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
                    const SizedBox(
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
                                color: Colors.blueAccent.withOpacity(
                                    _current == entry.key ? 0.9 : 0.4),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: const Color(0xFFC5DFF8),
                          borderRadius: const BorderRadius.only(
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
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 15),
                                  child: const Text(
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
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: FutureBuilder<List<String>>(
                              future: getItems(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Container();
                                } else if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  List<String> items = snapshot.data!;
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 180,
                                        child: isSpinning
                                            ? AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 100),
                                                child: Text(
                                                  items[random
                                                      .nextInt(items.length)],
                                                  style: const TextStyle(
                                                      fontSize: 8),
                                                ),
                                              )
                                            : Text(
                                                items[slotindex],
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 2, left: 10),
                                        child: const Text(
                                          "어떨까요??",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            backgroundColor:
                                                const Color(0xFFFFD577),
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 15,
                                                bottom: 15),
                                            side: const BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                          ),
                                          onPressed: () {
                                            spinSlotMachine(items);
                                          },
                                          child: const Text(
                                            "다음\n" "추천",
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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 30,
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: const Text(
                          "이벤트 / 광고",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
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
                    const SizedBox(
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
          bottomNavigationBar: SizedBox(
            height: 70,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                elevation: 20,
                currentIndex: 2,
                onTap: (int index) async {
                  switch (index) {
                    case 0: //검색
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AreaSearch()),
                      );
                      break;
                    case 1: //장바구니
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Cart()),
                      );
                      break;
                    case 2: //홈
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (route) => false,
                      );
                      break;
                    case 3: //주문내역
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderedList()),
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
                    icon: Stack(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                          ),
                          child: Icon(Icons.search),
                        ),
                        Positioned(
                          top: 0,
                          right: 3,
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child: Text(
                              '',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    label: '검색',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                          ),
                          child: Icon(Icons.shopping_cart_outlined),
                        ),
                        Positioned(
                          top: 0,
                          right: 3,
                          child: StreamBuilder(
                            stream: cartcollection
                                .where('userUid', isEqualTo: user!.uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot streamSnapshot) {
                              if (!streamSnapshot.hasData ||
                                  streamSnapshot.data!.docs.isEmpty) {
                                return Container(); // 데이터가 없는 경우 처리
                              }
                              if (streamSnapshot.hasError) {
                                debugPrint('에러');
                                Container();
                              }
                              if (streamSnapshot.hasData) {
                                int count = streamSnapshot.data!.docs.length;
                                return Container(
                                    alignment: Alignment.center,
                                    width: 15,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(count.toString()));
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        )
                      ],
                    ),
                    label: '장바구니',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                          ),
                          child: Icon(Icons.home_outlined),
                        ),
                        Positioned(
                          top: 0,
                          right: 3,
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child: Text(
                              '',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    label: '홈',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                          ),
                          child: Icon(Icons.receipt_long_outlined),
                        ),
                        Positioned(
                          top: 0,
                          right: 3,
                          child: StreamBuilder(
                            stream: ordercollection
                                .where('userUid', isEqualTo: user!.uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot streamSnapshot) {
                              if (!streamSnapshot.hasData ||
                                  streamSnapshot.data!.docs.isEmpty) {
                                return Container(); // 데이터가 없는 경우 처리
                              }
                              if (streamSnapshot.hasError) {
                                debugPrint('에러');
                                Container();
                              }
                              if (streamSnapshot.hasData) {
                                int count = streamSnapshot.data!.docs.length;
                                return Container(
                                    alignment: Alignment.center,
                                    width: 15,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(count.toString()));
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        )
                      ],
                    ),
                    label: '주문내역',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                          ),
                          child: Icon(Icons.face),
                        ),
                        Positioned(
                          top: 0,
                          right: 3,
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child: Text(
                              '',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
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
            backgroundColor: const Color(0xff161619),
            title: const Text(
              '앱을 종료하시겠습니까??',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    //onWillpop에 false 전달되어 앱이 종료되지 않는다.
                    Navigator.pop(context, false);
                  },
                  child: const Text('아니오')),
              TextButton(
                  onPressed: () {
                    //onWillpop에 true가 전달되어 앱이 종료 된다.
                    SystemNavigator.pop(); // 앱 종료
                  },
                  child: const Text('예')),
            ],
          );
        });
  }
}
