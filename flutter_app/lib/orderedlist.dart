import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/order_delivery.dart';
import 'package:flutter_app/write_review.dart';
import 'package:intl/intl.dart';

class OrderedList extends StatefulWidget {
  const OrderedList({super.key});
  @override
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
  late bool isLoading = true;

  @override
  void initState() {
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'jalnan'),
        home: Scaffold(
            backgroundColor: const Color(0xFFEEF1FF),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
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
                          height: 35,
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              iconSize: 35,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              onPressed: () {
                                CartCount();
                                OrderCount();
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
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white70,
                                    prefixIcon: const Icon(
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
                                            icon: const Icon(
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
                                            icon: const Icon(
                                              Icons.cancel,
                                              size: 20,
                                            ),
                                          ),
                                    hintText: '검색',
                                    labelStyle:
                                        TextStyle(color: Colors.grey[400]),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFD2DAFF)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFD2DAFF)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    border: const OutlineInputBorder(
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
                  const SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3.5),
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
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFB79E),
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
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 20),
                                          child: const Text(
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
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: StreamBuilder(
                                      stream: product
                                          .where('userUid',
                                              isEqualTo: _userID!.uid)
                                          .where('status', isNotEqualTo: '완료')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic>
                                              streamSnapshot) {
                                        if (!streamSnapshot.hasData ||
                                            streamSnapshot.data!.docs.isEmpty) {
                                          return const Text(
                                              '주문이 없습니다'); // 데이터가 없는 경우 처리
                                        }
                                        if (streamSnapshot.hasError) {
                                          debugPrint('에러');
                                          Container();
                                        }
                                        if (streamSnapshot.hasData) {
                                          return ListView.builder(
                                            shrinkWrap:
                                                true, // 리스트뷰 크기를 자동으로 조정
                                            physics:
                                                const NeverScrollableScrollPhysics(), // 스크롤 방지
                                            itemCount: streamSnapshot
                                                .data!.docs.length,
                                            itemBuilder: (context, index) {
                                              final List<DocumentSnapshot>
                                                  sortedDocs = List.from(
                                                      streamSnapshot
                                                          .data!.docs);
                                              sortedDocs.sort((a, b) {
                                                Timestamp timeA =
                                                    a['ordertime'];
                                                Timestamp timeB =
                                                    b['ordertime'];
                                                return timeB.compareTo(timeA);
                                              });
                                              final DateTime dateTime =
                                                  sortedDocs[index]['ordertime']
                                                      .toDate();
                                              String formattime =
                                                  DateFormat('yyyy-MM-dd HH:mm')
                                                      .format(dateTime);
                                              int itemPrice = int.parse(sortedDocs[
                                                      index][
                                                  'price']); // 아이템의 가격 (int 형으로 가정)
                                              int itemcount =
                                                  sortedDocs[index]['count'];
                                              int listlPrice =
                                                  itemPrice * itemcount;
                                              String areaName =
                                                  sortedDocs[index]
                                                      ['area_name'];
                                              Widget actionButton;
                                              if (searchText.isEmpty) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFffffff),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                25.0),
                                                        topRight:
                                                            Radius.circular(
                                                                25.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                25.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                25.0),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.7),
                                                          blurRadius: 5,
                                                          spreadRadius: 0,
                                                          offset: const Offset(
                                                              0, 7),
                                                        ),
                                                      ]),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5),
                                                            width: 185,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 10),
                                                                  child: Text(
                                                                    sortedDocs[
                                                                            index]
                                                                        [
                                                                        'area_name'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
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
                                                                            [
                                                                            'storeName'],
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            sortedDocs[index]['name'],
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                const EdgeInsets.only(top: 2),
                                                                            child:
                                                                                Text(
                                                                              '${sortedDocs[index]['count']}개',
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Text(
                                                                        '$listlPrice원',
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 1,
                                                                    bottom: 70),
                                                            width: 65,
                                                            height: 30,
                                                            color: setColor(
                                                                sortedDocs[
                                                                        index]
                                                                    ['status']),
                                                            /*decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),*/
                                                            child: Text(
                                                              sortedDocs[index]
                                                                  ['status'],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 80,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => Orderdelivery(
                                                                              sortedDocs[index]['area_name'],
                                                                              sortedDocs[index]['storeName'],
                                                                              sortedDocs[index]['name'],
                                                                              sortedDocs[index]['count'],
                                                                              sortedDocs[index]['ordertime'])),
                                                                    );
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xffAAC4FF),
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    '주문 상태',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 70),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    top: 15),
                                                            child: Text(
                                                              '주문번호 : ' +
                                                                  sortedDocs[
                                                                          index]
                                                                      [
                                                                      'ordernumber'],
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          13),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 15,
                                                                    top: 15),
                                                            child: Text(
                                                              formattime,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          8),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
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
                                                  margin: const EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFffffff),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                25.0),
                                                        topRight:
                                                            Radius.circular(
                                                                25.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                25.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                25.0),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.7),
                                                          blurRadius: 5,
                                                          spreadRadius: 0,
                                                          offset: const Offset(
                                                              0, 7),
                                                        ),
                                                      ]),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5),
                                                            width: 185,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 10),
                                                                  child: Text(
                                                                    sortedDocs[
                                                                            index]
                                                                        [
                                                                        'area_name'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
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
                                                                            [
                                                                            'storeName'],
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            sortedDocs[index]['name'],
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                const EdgeInsets.only(top: 2),
                                                                            child:
                                                                                Text(
                                                                              '${sortedDocs[index]['count']}개',
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Text(
                                                                        '$listlPrice원',
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 1,
                                                                    bottom: 70),
                                                            width: 65,
                                                            height: 30,
                                                            color: setColor(
                                                                sortedDocs[
                                                                        index]
                                                                    ['status']),
                                                            /*decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),*/
                                                            child: Text(
                                                              sortedDocs[index]
                                                                  ['status'],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 80,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => Orderdelivery(
                                                                              sortedDocs[index]['area_name'],
                                                                              sortedDocs[index]['storeName'],
                                                                              sortedDocs[index]['name'],
                                                                              sortedDocs[index]['count'],
                                                                              sortedDocs[index]['ordertime'])),
                                                                    );
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xffAAC4FF),
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    '주문 상태',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 70),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    top: 15),
                                                            child: Text(
                                                              '주문번호 : ' +
                                                                  sortedDocs[
                                                                          index]
                                                                      [
                                                                      'ordernumber'],
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          13),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 15,
                                                                    top: 15),
                                                            child: Text(
                                                              formattime,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          8),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
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
                            const SizedBox(height: 10),
                            //////////////////////////////////////////////////////////////////
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
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
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 20),
                                          child: const Text(
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
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('complete')
                                          .where('userUid',
                                              isEqualTo: _userID!.uid)
                                          .where('status', isEqualTo: '완료')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic>
                                              streamSnapshot) {
                                        if (!streamSnapshot.hasData ||
                                            streamSnapshot.data!.docs.isEmpty) {
                                          return Container(); // 데이터가 없는 경우 처리
                                        }
                                        if (streamSnapshot.hasData) {
                                          return ListView.builder(
                                            shrinkWrap:
                                                true, // 리스트뷰 크기를 자동으로 조정
                                            physics:
                                                const NeverScrollableScrollPhysics(), // 스크롤 방지
                                            itemCount: streamSnapshot
                                                .data!.docs.length,
                                            itemBuilder: (context, index) {
                                              final List<DocumentSnapshot>
                                                  sortedDocs = List.from(
                                                      streamSnapshot
                                                          .data!.docs);
                                              sortedDocs.sort((a, b) {
                                                Timestamp timeA =
                                                    a['ordertime'];
                                                Timestamp timeB =
                                                    b['ordertime'];
                                                return timeB.compareTo(timeA);
                                              });
                                              final DateTime dateTime =
                                                  sortedDocs[index]['ordertime']
                                                      .toDate();
                                              String formattime =
                                                  DateFormat('yyyy-MM-dd HH:mm')
                                                      .format(dateTime);
                                              int itemPrice = int.parse(sortedDocs[
                                                      index][
                                                  'price']); // 아이템의 가격 (int 형으로 가정)
                                              int itemcount =
                                                  sortedDocs[index]['count'];

                                              int listlPrice =
                                                  itemPrice * itemcount;
                                              String areaName =
                                                  sortedDocs[index]
                                                      ['area_name'];
                                              Widget actionButton;
                                              if (sortedDocs[index]['status'] ==
                                                      '완료' &&
                                                  sortedDocs[index]
                                                          ['boolreview'] ==
                                                      false) {
                                                actionButton = ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            WriteReview(
                                                          sortedDocs[index]
                                                              ['area_name'],
                                                          sortedDocs[index]
                                                              ['storeName'],
                                                          sortedDocs[index]
                                                              ['name'],
                                                          sortedDocs[index]
                                                              ['imageUrl'],
                                                          sortedDocs[index]
                                                              ['ordertime'],
                                                          sortedDocs[index]
                                                              ['storeUid'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xff92ABEB),
                                                  ),
                                                  child: const Text(
                                                    '리뷰 쓰기',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black),
                                                  ),
                                                );
                                              } else {
                                                actionButton = const SizedBox(
                                                    height:
                                                        50); // 상태가 다른 경우 버튼을 숨김
                                              }
                                              if (searchText.isEmpty) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFffffff),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                25.0),
                                                        topRight:
                                                            Radius.circular(
                                                                25.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                25.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                25.0),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.7),
                                                          blurRadius: 5,
                                                          spreadRadius: 0,
                                                          offset: const Offset(
                                                              0, 7),
                                                        ),
                                                      ]),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                          Container(
                                                            width: 185,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 10),
                                                                  child: Text(
                                                                    sortedDocs[
                                                                            index]
                                                                        [
                                                                        'area_name'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
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
                                                                            [
                                                                            'storeName'],
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            sortedDocs[index]['name'],
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                const EdgeInsets.only(top: 2),
                                                                            child:
                                                                                Text(
                                                                              '${sortedDocs[index]['count']}개',
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Text(
                                                                        '$listlPrice원',
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 1,
                                                                    bottom: 75),
                                                            width: 65,
                                                            height: 30,
                                                            color: setColor(
                                                                sortedDocs[
                                                                        index]
                                                                    ['status']),
                                                            /*decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),*/
                                                            child: Text(
                                                              sortedDocs[index]
                                                                  ['status'],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 80,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                const SizedBox(
                                                                    height: 5),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      null,
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xffAAC4FF),
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    '주문 상태',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 30),
                                                                actionButton,
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    top: 15),
                                                            child: Text(
                                                              '주문번호 : ' +
                                                                  sortedDocs[
                                                                          index]
                                                                      [
                                                                      'ordernumber'],
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          13),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 15,
                                                                    top: 15),
                                                            child: Text(
                                                              formattime,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          8),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
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
                                                  margin: const EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFffffff),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                25.0),
                                                        topRight:
                                                            Radius.circular(
                                                                25.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                25.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                25.0),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.7),
                                                          blurRadius: 5,
                                                          spreadRadius: 0,
                                                          offset: const Offset(
                                                              0, 7),
                                                        ),
                                                      ]),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                          Container(
                                                            width: 185,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 10),
                                                                  child: Text(
                                                                    sortedDocs[
                                                                            index]
                                                                        [
                                                                        'area_name'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
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
                                                                            [
                                                                            'storeName'],
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            sortedDocs[index]['name'],
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                const EdgeInsets.only(top: 2),
                                                                            child:
                                                                                Text(
                                                                              '${sortedDocs[index]['count']}개',
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Text(
                                                                        '$listlPrice원',
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 1,
                                                                    bottom: 75),
                                                            width: 65,
                                                            height: 30,
                                                            color: setColor(
                                                                sortedDocs[
                                                                        index]
                                                                    ['status']),
                                                            /*decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),*/
                                                            child: Text(
                                                              sortedDocs[index]
                                                                  ['status'],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 80,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                const SizedBox(
                                                                    height: 5),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      null,
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xffAAC4FF),
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    '주문 상태',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 30),
                                                                actionButton,
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    top: 15),
                                                            child: Text(
                                                              '주문번호 : ' +
                                                                  sortedDocs[
                                                                          index]
                                                                      [
                                                                      'ordernumber'],
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          13),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 15,
                                                                    top: 15),
                                                            child: Text(
                                                              formattime,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          8),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
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
    if (count != 0) {
      setState(() {
        cartcount = count;
      });
    }
  }

  Future<void> OrderCount() async {
    QuerySnapshot snapshot = await product
        .where('userUid', isEqualTo: _userID!.uid)
        .where('status', isNotEqualTo: '완료')
        .get();

    int count = snapshot.docs.length;
    if (count != 0) {
      setState(() {
        ordercount = count;
      });
    }
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
