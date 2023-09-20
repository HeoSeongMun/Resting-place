import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/write_review.dart';

class OrderedList extends StatefulWidget {
  OrderedList({super.key});
  _OrderedList createState() => _OrderedList();
}

class _OrderedList extends State<OrderedList> {
  final _userID = FirebaseAuth.instance.currentUser;
  final TextEditingController filter = TextEditingController();
  CollectionReference product = FirebaseFirestore.instance.collection('order');
  FocusNode focusNode = FocusNode();
  String searchText = "";

  //진행중
  List<String> ing_areanameList = [];
  List<String> ing_nameList = [];
  List<String> ing_statusList = [];
  List<String> ing_storenameList = [];
  List<Timestamp> ing_ordertimeList = [];
  List<String> ing_priceList = [];
  List<String> ing_imageUrlList = [];
  //진행중

  //지난주문 저장 리스트
  List<String> uniqueData1 = [];
  List<String> uniqueData2 = [];
  List<String> uniqueData3 = [];
  List<String> uniqueData4 = [];
  List<Timestamp> uniqueData5 = [];
  List<String> uniqueData6 = [];
  List<String> uniqueData7 = [];
  List<bool> uniqueData8 = [];
  //지난주문 저장 리스트

  _OrderedList() {
    filter.addListener(() {
      setState(() {
        searchText = filter.text;
      });
    });
  }
  List<DocumentSnapshot> documentList = [];
  //진행중인 데이터 가져오기 및 정렬 함수
  Future<void> ingData() async {
    QuerySnapshot snapshot =
        await product.where('userUid', isEqualTo: _userID!.uid).get();
    List<DocumentSnapshot> documents =
        snapshot.docs.where((doc) => doc['status'] != '완료').toList();

    documents.sort((a, b) {
      Timestamp timeA = a['ordertime'];
      Timestamp timeB = b['ordertime'];
      return timeB.compareTo(timeA); // 정렬
    });
    documentList = documents;
    List<String> uniqueSet1 = [];
    List<String> uniqueSet2 = [];
    List<String> uniqueSet3 = [];
    List<String> uniqueSet4 = [];
    List<Timestamp> uniqueSet5 = [];
    List<String> uniqueSet6 = [];
    List<String> uniqueSet7 = [];

    for (var doc in documents) {
      String data1 = doc['area_name'];
      String data2 = doc['name'];
      String data3 = doc['status'];
      String data4 = doc['storeName'];
      Timestamp data5 = doc['ordertime'];
      String data6 = doc['price'];
      String data7 = doc['imageUrl'];
      uniqueSet1.add(data1);
      uniqueSet2.add(data2);
      uniqueSet3.add(data3);
      uniqueSet4.add(data4);
      uniqueSet5.add(data5);
      uniqueSet6.add(data6);
      uniqueSet7.add(data7);
    }

    setState(() {
      ing_areanameList = uniqueSet1.toList();
      ing_nameList = uniqueSet2.toList();
      ing_statusList = uniqueSet3.toList();
      ing_storenameList = uniqueSet4.toList();
      ing_ordertimeList = uniqueSet5.toList();
      ing_priceList = uniqueSet6.toList();
      ing_imageUrlList = uniqueSet7.toList();
    });
  }

  //지난주문 데이터 가져오기 및 정렬 함수
  Future<void> pastData() async {
    QuerySnapshot snapshot = await product
        .where('userUid', isEqualTo: _userID!.uid)
        .where('status', isEqualTo: '완료')
        .get();
    List<DocumentSnapshot> documents = snapshot.docs;
    documents.sort((a, b) {
      Timestamp timeA = a['ordertime'];
      Timestamp timeB = b['ordertime'];
      return timeB.compareTo(timeA); // 정렬
    });
    List<String> uniqueSet1 = [];
    List<String> uniqueSet2 = [];
    List<String> uniqueSet3 = [];
    List<String> uniqueSet4 = [];
    List<Timestamp> uniqueSet5 = [];
    List<String> uniqueSet6 = [];
    List<String> uniqueSet7 = [];
    List<bool> uniqueSet8 = [];

    for (var doc in documents) {
      String data1 = doc['area_name'];
      String data2 = doc['name'];
      String data3 = doc['status'];
      String data4 = doc['storeName'];
      Timestamp data5 = doc['ordertime'];
      String data6 = doc['price'];
      String data7 = doc['imageUrl'];
      bool data8 = doc['boolreview'];
      uniqueSet1.add(data1);
      uniqueSet2.add(data2);
      uniqueSet3.add(data3);
      uniqueSet4.add(data4);
      uniqueSet5.add(data5);
      uniqueSet6.add(data6);
      uniqueSet7.add(data7);
      uniqueSet8.add(data8);
    }

    setState(() {
      uniqueData1 = uniqueSet1.toList();
      uniqueData2 = uniqueSet2.toList();
      uniqueData3 = uniqueSet3.toList();
      uniqueData4 = uniqueSet4.toList();
      uniqueData5 = uniqueSet5.toList();
      uniqueData6 = uniqueSet6.toList();
      uniqueData7 = uniqueSet7.toList();
      uniqueData8 = uniqueSet8.toList();
    });
  }

  void initState() {
    super.initState();
    pastData();
    ingData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pastData();
    ingData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFFEEF1FF),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFD2DAFF),
                        borderRadius: BorderRadius.only(
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
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              iconSize: 35,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Container(
                              child: Flexible(
                                child: TextField(
                                  focusNode: focusNode,
                                  controller: filter,
                                  onChanged: (text) {
                                    setState(() {
                                      searchText = text;
                                    });
                                  },
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white70,
                                    prefixIcon: Icon(
                                      Icons.search,
                                    ),
                                    suffixIcon: focusNode.hasFocus
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                filter.clear();
                                                searchText = "";
                                              });
                                            },
                                            icon: Icon(
                                              Icons.cancel,
                                              size: 20,
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                filter.clear();
                                                searchText = "";
                                              });
                                            },
                                            icon: Icon(
                                              Icons.cancel,
                                              size: 20,
                                            ),
                                          ),
                                    hintText: '검색',
                                    labelStyle:
                                        TextStyle(color: Colors.grey[400]),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFD2DAFF)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFD2DAFF)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFD2DAFF)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                                margin: EdgeInsets.only(left: 10, top: 20),
                                child: Text(
                                  "진행중",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('order')
                                .where('userUid', isEqualTo: _userID!.uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> streamSnapshot) {
                              if (!streamSnapshot.hasData ||
                                  streamSnapshot.data!.docs.isEmpty) {
                                return Container(); // 데이터가 없는 경우 처리
                              }
                              if (streamSnapshot.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true, // 리스트뷰 크기를 자동으로 조정
                                  physics:
                                      NeverScrollableScrollPhysics(), // 스크롤 방지
                                  itemCount: ing_areanameList.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];
                                    String ing_areaname =
                                        ing_areanameList[index]; //area_name
                                    String ing_name =
                                        ing_nameList[index]; //menu_name
                                    String ing_status =
                                        ing_statusList[index]; //status
                                    String ing_storename =
                                        ing_storenameList[index]; //store_name
                                    Timestamp ing_ordertime =
                                        ing_ordertimeList[index]; //time
                                    String ing_price =
                                        ing_priceList[index]; //tot_price
                                    String ing_imgeUrl =
                                        ing_imageUrlList[index]; //imageUrl
                                    Widget actionButton;
                                    if (ing_status.toString() == '조리완료') {
                                      actionButton = ElevatedButton(
                                        onPressed: () async {
                                          String documentID =
                                              documentList[index].id;
                                          await FirebaseFirestore.instance
                                              .collection('order')
                                              .doc(documentID)
                                              .update({'status': '완료'});
                                          setState(() {
                                            ingData();
                                            pastData();
                                          });
                                        },
                                        child: Text(
                                          '수령 완료',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff92ABEB),
                                        ),
                                      );
                                    } else {
                                      actionButton =
                                          SizedBox.shrink(); // 상태가 다른 경우 버튼을 숨김
                                    }
                                    if (searchText.isEmpty) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 10),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFffffff),
                                            borderRadius: BorderRadius.only(
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
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              width: 150,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    height: 75,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(ing_areaname,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                        Text(
                                                          ing_ordertime
                                                              .toDate()
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 75,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          ing_storename,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          ing_name,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          ing_price + '원',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Container(
                                              width: 60,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 30,
                                                    color: setColor(ing_status),
                                                    /*decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black)),*/
                                                    child: Text(
                                                      ing_status,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Container(
                                              width: 80,
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(height: 5),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      '상세 주문',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Colors.black),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Color(0xffAAC4FF),
                                                    ),
                                                  ),
                                                  SizedBox(height: 30),
                                                  actionButton,
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                    if (ing_areaname
                                            .toString()
                                            .contains(searchText) ||
                                        ing_ordertime
                                            .toDate()
                                            .toString()
                                            .contains(searchText)) {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: Card(
                                          child: Container(
                                            height: 150,
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: 150,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        height: 75,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(ing_areaname,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                            Text(
                                                              ing_ordertime
                                                                  .toDate()
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 10),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 75,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ing_storename,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                            Text(
                                                              ing_name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                            Text(
                                                              ing_price + '원',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 30),
                                                Container(
                                                  width: 60,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 15),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 30,
                                                        color: setColor(
                                                            ing_status),
                                                        /*decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.black)),*/
                                                        child: Text(
                                                          ing_status,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                ),
                                                Container(
                                                  width: 80,
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(height: 5),
                                                      ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          '상세 주문',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              Color(0xffAAC4FF),
                                                        ),
                                                      ),
                                                      SizedBox(height: 30),
                                                      actionButton,
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  },
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  //////////////////////////////////////////////////////////////////
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                                margin: EdgeInsets.only(left: 10, top: 20),
                                child: Text(
                                  "지난주문",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('order')
                                .where('userUid', isEqualTo: _userID!.uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> streamSnapshot) {
                              if (!streamSnapshot.hasData ||
                                  streamSnapshot.data!.docs.isEmpty) {
                                return Container(); // 데이터가 없는 경우 처리
                              }
                              if (streamSnapshot.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true, // 리스트뷰 크기를 자동으로 조정
                                  physics:
                                      NeverScrollableScrollPhysics(), // 스크롤 방지
                                  itemCount: uniqueData1.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];
                                    String data1 =
                                        uniqueData1[index]; //area_name
                                    String data2 =
                                        uniqueData2[index]; //menu_name
                                    String data3 = uniqueData3[index]; //status
                                    String data4 =
                                        uniqueData4[index]; //store_name
                                    Timestamp data5 = uniqueData5[index]; //time
                                    String data6 =
                                        uniqueData6[index]; //tot_price
                                    String data7 =
                                        uniqueData7[index]; //imageUrl
                                    bool data8 =
                                        uniqueData8[index]; //boolreview
                                    Widget actionButton;
                                    if (data3 == '조리완료') {
                                      actionButton = ElevatedButton(
                                        onPressed: () async {
                                          String documentID =
                                              documentSnapshot.id;
                                          await FirebaseFirestore.instance
                                              .collection('order')
                                              .doc(documentID)
                                              .update({'status': '완료'});
                                        },
                                        child: Text(
                                          '수령 완료',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff92ABEB),
                                        ),
                                      );
                                    } else if (data3 == '완료' &&
                                        data8 == false) {
                                      actionButton = ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => WriteReview(
                                                data1,
                                                data4,
                                                data2,
                                                data7,
                                                data5,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          '리뷰 쓰기',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff92ABEB),
                                        ),
                                      );
                                    } else {
                                      actionButton =
                                          SizedBox.shrink(); // 상태가 다른 경우 버튼을 숨김
                                    }
                                    if (searchText.isEmpty) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 10),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFffffff),
                                            borderRadius: BorderRadius.only(
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
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              width: 150,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    height: 75,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(data1,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                        Text(
                                                          data5
                                                              .toDate()
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 75,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data4,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          data2,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          data6 + '원',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Container(
                                              width: 60,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 30,
                                                    color: setColor(data3),
                                                    /*decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black)),*/
                                                    child: Text(
                                                      data3,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Container(
                                              width: 80,
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(height: 5),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      '상세 주문',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Colors.black),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Color(0xffAAC4FF),
                                                    ),
                                                  ),
                                                  SizedBox(height: 30),
                                                  actionButton,
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                    if (data1.toString().contains(searchText) ||
                                        data5
                                            .toDate()
                                            .toString()
                                            .contains(searchText)) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 10),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFffffff),
                                            borderRadius: BorderRadius.only(
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
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              width: 150,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    height: 75,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(data1,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                        Text(
                                                          data5
                                                              .toDate()
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 75,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data4,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          data2,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          data6 + '원',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Container(
                                              width: 60,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 30,
                                                    color: setColor(data3),
                                                    /*decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black)),*/
                                                    child: Text(
                                                      data3,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Container(
                                              width: 80,
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(height: 5),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      '상세 주문',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Colors.black),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Color(0xffAAC4FF),
                                                    ),
                                                  ),
                                                  SizedBox(height: 30),
                                                  actionButton,
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                    return Container();
                                  },
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Color setColor(String status) {
    switch (status) {
      case '주문중':
        return Colors.blueGrey;
      case '조리중':
        return Colors.yellow;
      case '조리완료':
        return Colors.green;
      case '완료':
        return Colors.grey;
      default:
        return Colors.white;
    }
  }
}
