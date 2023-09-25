import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/order_delivery.dart';
import 'package:flutter_app/write_review.dart';
import 'package:intl/intl.dart';

class OrderedList extends StatefulWidget {
  OrderedList({super.key});
  _OrderedList createState() => _OrderedList();
}

class _OrderedList extends State<OrderedList> {
  final _userID = FirebaseAuth.instance.currentUser;
  final TextEditingController filter = TextEditingController();
  CollectionReference product = FirebaseFirestore.instance.collection('order');
  CollectionReference cartcollection =
      FirebaseFirestore.instance.collection('shoppingBasket');
  FocusNode focusNode = FocusNode();
  String searchText = "";
  int cartcount = 0;
  int ordercount = 0;
  _OrderedList() {
    filter.addListener(() {
      setState(() {
        searchText = filter.text;
      });
    });
  }

  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'jalnan'),
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
                                Navigator.pop(context, ordercount);
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
                            stream: product
                                .where('userUid', isEqualTo: _userID!.uid)
                                .where('status', isNotEqualTo: '완료')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> streamSnapshot) {
                              if (!streamSnapshot.hasData ||
                                  streamSnapshot.data!.docs.isEmpty) {
                                debugPrint('데이터가 없습니다.');
                                return Container(); // 데이터가 없는 경우 처리
                              }
                              if (streamSnapshot.hasError) {
                                debugPrint('에러');
                                Container();
                              }
                              if (streamSnapshot.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true, // 리스트뷰 크기를 자동으로 조정
                                  physics:
                                      NeverScrollableScrollPhysics(), // 스크롤 방지
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final List<DocumentSnapshot> sortedDocs =
                                        List.from(streamSnapshot.data!.docs);
                                    sortedDocs.sort((a, b) {
                                      Timestamp timeA = a['ordertime'];
                                      Timestamp timeB = b['ordertime'];
                                      return timeB.compareTo(timeA);
                                    });
                                    final DateTime dateTime =
                                        sortedDocs[index]['ordertime'].toDate();
                                    String formattime =
                                        DateFormat('yyyy-MM-dd HH:mm')
                                            .format(dateTime);
                                    int itemPrice = int.parse(sortedDocs[index]
                                        ['price']); // 아이템의 가격 (int 형으로 가정)
                                    int itemcount = sortedDocs[index]['count'];
                                    int listlPrice = itemPrice * itemcount;
                                    String areaName =
                                        sortedDocs[index]['area_name'];
                                    Widget actionButton;
                                    if (sortedDocs[index]['status']
                                            .toString() ==
                                        '조리완료') {
                                      actionButton = ElevatedButton(
                                        onPressed: () async {
                                          String documentID =
                                              sortedDocs[index].id;
                                          await FirebaseFirestore.instance
                                              .collection('order')
                                              .doc(documentID)
                                              .update({'status': '완료'});
                                        },
                                        child: Text(
                                          '수령 완료',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff92ABEB),
                                        ),
                                      );
                                    } else {
                                      actionButton = SizedBox(
                                        height: 50,
                                      ); // 상태가 다른 경우 버튼을 숨김
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
                                        child: Column(
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 185,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10, top: 10),
                                                        child: Text(
                                                          sortedDocs[index]
                                                              ['area_name'],
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 12),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              sortedDocs[index]
                                                                  ['storeName'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  sortedDocs[
                                                                          index]
                                                                      ['name'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              2),
                                                                  child: Text(
                                                                    sortedDocs[index]['count']
                                                                            .toString() +
                                                                        '개',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                              listlPrice
                                                                      .toString() +
                                                                  '원',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      left: 1, bottom: 75),
                                                  width: 65,
                                                  height: 30,
                                                  color: setColor(
                                                      sortedDocs[index]
                                                          ['status']),
                                                  /*decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),*/
                                                  child: Text(
                                                    sortedDocs[index]['status'],
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: 80,
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(height: 5),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => Orderdelivery(
                                                                    sortedDocs[
                                                                            index]
                                                                        [
                                                                        'area_name'],
                                                                    sortedDocs[
                                                                            index]
                                                                        [
                                                                        'storeName'],
                                                                    sortedDocs[
                                                                            index]
                                                                        [
                                                                        'name'],
                                                                    sortedDocs[
                                                                            index]
                                                                        [
                                                                        'count'],
                                                                    sortedDocs[
                                                                            index]
                                                                        [
                                                                        'ordertime'])),
                                                          );
                                                        },
                                                        child: Text(
                                                          '주문 현황',
                                                          style: TextStyle(
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 15, top: 10),
                                                  child: Text(
                                                    formattime,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    if (areaName
                                            .toString()
                                            .contains(searchText) ||
                                        formattime
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
                                        child: Column(
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 185,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10, top: 10),
                                                        child: Text(
                                                          sortedDocs[index]
                                                              ['area_name'],
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 12),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              sortedDocs[index]
                                                                  ['storeName'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  sortedDocs[
                                                                          index]
                                                                      ['name'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              2),
                                                                  child: Text(
                                                                    sortedDocs[index]['count']
                                                                            .toString() +
                                                                        '개',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                              listlPrice
                                                                      .toString() +
                                                                  '원',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      left: 1, bottom: 75),
                                                  width: 65,
                                                  height: 30,
                                                  color: setColor(
                                                      sortedDocs[index]
                                                          ['status']),
                                                  /*decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),*/
                                                  child: Text(
                                                    sortedDocs[index]['status'],
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: 80,
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(height: 5),
                                                      ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          '주문 현황',
                                                          style: TextStyle(
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 15, top: 10),
                                                  child: Text(
                                                    formattime,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      Container();
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
                                .where('status', isEqualTo: '완료')
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
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final List<DocumentSnapshot> sortedDocs =
                                        List.from(streamSnapshot.data!.docs);
                                    sortedDocs.sort((a, b) {
                                      Timestamp timeA = a['ordertime'];
                                      Timestamp timeB = b['ordertime'];
                                      return timeB.compareTo(timeA);
                                    });
                                    final DateTime dateTime =
                                        sortedDocs[index]['ordertime'].toDate();
                                    String formattime =
                                        DateFormat('yyyy-MM-dd HH:mm')
                                            .format(dateTime);
                                    int itemPrice = int.parse(sortedDocs[index]
                                        ['price']); // 아이템의 가격 (int 형으로 가정)
                                    int itemcount = sortedDocs[index]['count'];

                                    int listlPrice = itemPrice * itemcount;
                                    String areaName =
                                        sortedDocs[index]['area_name'];
                                    Widget actionButton;
                                    if (sortedDocs[index]['status'] == '조리완료') {
                                      actionButton = ElevatedButton(
                                        onPressed: () async {
                                          String documentID =
                                              sortedDocs[index].id;
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
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff92ABEB),
                                        ),
                                      );
                                    } else if (sortedDocs[index]['status'] ==
                                            '완료' &&
                                        sortedDocs[index]['boolreview'] ==
                                            false) {
                                      actionButton = ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => WriteReview(
                                                sortedDocs[index]['area_name'],
                                                sortedDocs[index]['storeName'],
                                                sortedDocs[index]['name'],
                                                sortedDocs[index]['imageUrl'],
                                                sortedDocs[index]['ordertime'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          '리뷰 쓰기',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff92ABEB),
                                        ),
                                      );
                                    } else {
                                      actionButton = SizedBox(
                                          height: 50); // 상태가 다른 경우 버튼을 숨김
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
                                        child: Column(
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 185,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10, top: 10),
                                                        child: Text(
                                                          sortedDocs[index]
                                                              ['area_name'],
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 12),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              sortedDocs[index]
                                                                  ['storeName'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  sortedDocs[
                                                                          index]
                                                                      ['name'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              2),
                                                                  child: Text(
                                                                    sortedDocs[index]['count']
                                                                            .toString() +
                                                                        '개',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                              listlPrice
                                                                      .toString() +
                                                                  '원',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      left: 1, bottom: 75),
                                                  width: 65,
                                                  height: 30,
                                                  color: setColor(
                                                      sortedDocs[index]
                                                          ['status']),
                                                  /*decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),*/
                                                  child: Text(
                                                    sortedDocs[index]['status'],
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: 80,
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(height: 5),
                                                      ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          '주문 현황',
                                                          style: TextStyle(
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 15, top: 10),
                                                  child: Text(
                                                    formattime,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    if (areaName
                                            .toString()
                                            .contains(searchText) ||
                                        formattime
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
                                        child: Column(
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 185,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10, top: 10),
                                                        child: Text(
                                                          sortedDocs[index]
                                                              ['area_name'],
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 12),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              sortedDocs[index]
                                                                  ['storeName'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  sortedDocs[
                                                                          index]
                                                                      ['name'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              2),
                                                                  child: Text(
                                                                    sortedDocs[index]['count']
                                                                            .toString() +
                                                                        '개',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                              listlPrice
                                                                      .toString() +
                                                                  '원',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      left: 1, bottom: 75),
                                                  width: 65,
                                                  height: 30,
                                                  color: setColor(
                                                      sortedDocs[index]
                                                          ['status']),
                                                  /*decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),*/
                                                  child: Text(
                                                    sortedDocs[index]['status'],
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: 80,
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(height: 5),
                                                      ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          '주문 현황',
                                                          style: TextStyle(
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 15, top: 10),
                                                  child: Text(
                                                    formattime,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
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

  Future<void> CartCount() async {
    QuerySnapshot snapshot =
        await cartcollection.where('userUid', isEqualTo: _userID!.uid).get();

    int count = snapshot.docs.length;

    setState(() {
      cartcount = count;
    });
  }

  Future<void> OrderCount() async {
    QuerySnapshot snapshot = await product
        .where('userUid', isEqualTo: _userID!.uid)
        .where('status', isNotEqualTo: '완료')
        .get();

    int count = snapshot.docs.length;

    setState(() {
      ordercount = count;
    });
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
