import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/cart.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/menu.dart';
import 'package:flutter_app/orderedlist.dart';
import 'package:flutter_app/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class Restaurant extends StatefulWidget {
  Restaurant(this.areaName, this.imageUrl, {super.key});

  String areaName = '';
  String imageUrl = '';

  @override
  State<Restaurant> createState() => _Restaurant();
}

class _Restaurant extends State<Restaurant> {
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  CollectionReference cartcollection =
      FirebaseFirestore.instance.collection('shoppingBasket');
  CollectionReference reviewcollection =
      FirebaseFirestore.instance.collection('testreviewlist');
  final user = FirebaseAuth.instance.currentUser;
  int cartcount = 0;
  int ordercount = 0;
  @override
  void initState() {
    super.initState();
    CartCount();
    OrderCount();
  }

  Future<AverageInfo> averageData(storename) async {
    QuerySnapshot reviewsnapshot =
        await reviewcollection.where('store_name', isEqualTo: storename).get();
    int totalGrade = 0;
    int numberOfGrades = reviewsnapshot.docs.length;
    double averagegrade = 0.0;
    double gradescount = 0.0;
    for (var doc in reviewsnapshot.docs) {
      num grade = doc['grade'];
      totalGrade += grade.toInt();
    }
    averagegrade = totalGrade / numberOfGrades.toDouble();
    gradescount = numberOfGrades.toDouble();

    return AverageInfo(averagegrade, gradescount);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'jalnan'),
      home: Scaffold(
        backgroundColor: const Color(0xFFEEF1FF),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFD2DAFF),
                    borderRadius: const BorderRadius.only(
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
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            iconSize: 25,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            onPressed: () {
                              Navigator.pop(context, cartcount);
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          right: 40, left: 40, bottom: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.imageUrl,
                          height: 150,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.areaName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 385,
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
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('testlogin')
                        .where("restAreaName", isEqualTo: widget.areaName)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!streamSnapshot.hasData ||
                          streamSnapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: const Text('등록된 음식점이 없습니다'),
                          ),
                        ); // 데이터가 없는 경우 처리
                      }
                      if (streamSnapshot.hasError) {
                        debugPrint('에러');
                        Container();
                      }
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            if (documentSnapshot['storeName'] == '') {
                              return Container();
                            }
                            return FutureBuilder(
                              future: averageData(
                                  documentSnapshot['storeName'].toString()),
                              builder: (BuildContext context,
                                  AsyncSnapshot<AverageInfo> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                double averagegrade =
                                    snapshot.data!.averageGrade;
                                NumberFormat formatter =
                                    NumberFormat("#,##0.00", "en_US");
                                String formattedaverage =
                                    formatter.format(averagegrade);
                                int gradescount =
                                    snapshot.data!.gradesCount.toInt();

                                final bool status = documentSnapshot['status'];
                                return status == false
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 5, bottom: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(25.0),
                                              topRight: Radius.circular(25.0),
                                              bottomLeft: Radius.circular(25.0),
                                              bottomRight:
                                                  Radius.circular(25.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.7),
                                                blurRadius: 5,
                                                spreadRadius: 0,
                                                offset: const Offset(0, 7),
                                              ),
                                            ]),
                                        child: Stack(
                                          children: [
                                            ListTile(
                                              leading: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5),
                                                child: documentSnapshot[
                                                            'storeimageUrl']
                                                        .toString()
                                                        .isEmpty
                                                    ? Image.asset(
                                                        'assets/images/cross.png',
                                                        height: 120,
                                                        width: 55,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.network(
                                                        documentSnapshot[
                                                            'storeimageUrl'],
                                                        height: 120,
                                                        width: 55,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                              title: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  child: Text(documentSnapshot[
                                                      'storeName'])),
                                              subtitle: Row(
                                                children: [
                                                  Container(
                                                    width: 170,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: documentSnapshot[
                                                                'signaturemenu']
                                                            .toString()
                                                            .isEmpty
                                                        ? const Text(
                                                            '대표메뉴: ' '',
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                          )
                                                        : Text(
                                                            '대표메뉴: ' +
                                                                documentSnapshot[
                                                                    'signaturemenu'],
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10),
                                                          ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 3),
                                                        width: 80,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          '평점 : ${snapshot.data!.averageGrade.isNaN ? '0' : snapshot.data!.averageGrade.toStringAsFixed(2)}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 2),
                                                            child:
                                                                RatingBarIndicator(
                                                              rating: snapshot
                                                                      .data!
                                                                      .averageGrade
                                                                      .isNaN
                                                                  ? 0.0
                                                                  : snapshot
                                                                      .data!
                                                                      .averageGrade,
                                                              direction: Axis
                                                                  .horizontal,
                                                              itemCount: 5,
                                                              itemSize: 10,
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5,
                                                                    top: 2),
                                                            child: Text(
                                                              '(${snapshot.data!.gradesCount})',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          8),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    '영업준비중',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.red[900]),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 5, bottom: 10),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFffffff),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(25.0),
                                              topRight: Radius.circular(25.0),
                                              bottomLeft: Radius.circular(25.0),
                                              bottomRight:
                                                  Radius.circular(25.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.7),
                                                blurRadius: 5,
                                                spreadRadius: 0,
                                                offset: const Offset(0, 7),
                                              ),
                                            ]),
                                        child: ListTile(
                                          leading: Container(
                                            margin:
                                                const EdgeInsets.only(left: 5),
                                            child: documentSnapshot[
                                                        'storeimageUrl']
                                                    .toString()
                                                    .isEmpty
                                                ? Image.asset(
                                                    'assets/images/cross.png',
                                                    height: 120,
                                                    width: 55,
                                                    fit: BoxFit.cover)
                                                : Image.network(
                                                    documentSnapshot[
                                                        'storeimageUrl'],
                                                    height: 120,
                                                    width: 55,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          title: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Text(documentSnapshot[
                                                  'storeName'])),
                                          subtitle: Row(
                                            children: [
                                              Container(
                                                width: 170,
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: documentSnapshot[
                                                            'signaturemenu']
                                                        .toString()
                                                        .isEmpty
                                                    ? const Text(
                                                        '대표메뉴: ' '',
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      )
                                                    : Text(
                                                        '대표메뉴: ' +
                                                            documentSnapshot[
                                                                'signaturemenu'],
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 3),
                                                    width: 70,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      '평점 : ${snapshot.data!.averageGrade.isNaN ? '0' : snapshot.data!.averageGrade.toStringAsFixed(2)}',
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 2),
                                                        child:
                                                            RatingBarIndicator(
                                                          rating: snapshot
                                                                  .data!
                                                                  .averageGrade
                                                                  .isNaN
                                                              ? 0.0
                                                              : snapshot.data!
                                                                  .averageGrade,
                                                          direction:
                                                              Axis.horizontal,
                                                          itemCount: 5,
                                                          itemSize: 10,
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 5, top: 2),
                                                        child: Text(
                                                          '(${snapshot.data!.gradesCount.toInt()})',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 8),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          onTap: () async {
                                            if (documentSnapshot['status'] ==
                                                true) {
                                              final result =
                                                  await Navigator.of(context)
                                                      .push(
                                                MaterialPageRoute(
                                                  builder: (context) => Menu(
                                                      widget.areaName,
                                                      documentSnapshot[
                                                          'storeName'],
                                                      documentSnapshot[
                                                              'storeimageUrl']
                                                          .toString(),
                                                      snapshot
                                                          .data!.averageGrade,
                                                      snapshot.data!.gradesCount
                                                          .toInt()),
                                                ),
                                              );
                                              if (result != null) {
                                                setState(() {
                                                  CartCount();
                                                });
                                              }
                                            }
                                          },
                                        ),
                                      );
                              },
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
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
              currentIndex: 0,
              onTap: (int index) async {
                switch (index) {
                  case 0: //검색
                    final result = await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AreaSearch()),
                      (route) => false,
                    );
                    break;
                  case 1: //장바구니
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Cart()),
                    );

                    break;
                  case 2: //홈
                    await Navigator.pushAndRemoveUntil(
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
    );
  }

  Future<void> CartCount() async {
    QuerySnapshot snapshot =
        await cartcollection.where('userUid', isEqualTo: user!.uid).get();

    int count = snapshot.docs.length;
    if (count != 0) {
      setState(() {
        cartcount = count;
      });
    }
  }

  Future<void> OrderCount() async {
    QuerySnapshot snapshot = await ordercollection
        .where('userUid', isEqualTo: user!.uid)
        .where('status', isNotEqualTo: '완료')
        .get();

    int count = snapshot.docs.length;
    if (count != 0) {
      setState(() {
        ordercount = count;
      });
    }
  }
}

class AverageInfo {
  double averageGrade;
  double gradesCount;

  AverageInfo(this.averageGrade, this.gradesCount);
}
