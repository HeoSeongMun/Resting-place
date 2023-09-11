import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderedList extends StatefulWidget {
  OrderedList({super.key});
  _OrderedList createState() => _OrderedList();
}

class _OrderedList extends State<OrderedList> {
  final _userID = FirebaseAuth.instance.currentUser;
  final TextEditingController filter = TextEditingController();
  CollectionReference product =
      FirebaseFirestore.instance.collection('testorder');
  FocusNode focusNode = FocusNode();
  String searchText = "";
  List<String> uniqueData1 = [];
  List<String> uniqueData2 = [];
  List<String> uniqueData3 = [];
  List<String> uniqueData4 = [];
  List<Timestamp> uniqueData5 = [];
  List<String> uniqueData6 = [];

  _OrderedList() {
    filter.addListener(() {
      setState(() {
        searchText = filter.text;
      });
    });
  }

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    QuerySnapshot snapshot =
        await product.where('userID', isEqualTo: _userID!.email).get();
    List<DocumentSnapshot> documents = snapshot.docs;
    documents.sort((a, b) {
      Timestamp timeA = a['time'];
      Timestamp timeB = b['time'];
      return timeA.compareTo(timeB); // 내림차순 정렬
    });
    List<String> uniqueSet1 = [];
    List<String> uniqueSet2 = [];
    List<String> uniqueSet3 = [];
    List<String> uniqueSet4 = [];
    List<Timestamp> uniqueSet5 = [];
    List<String> uniqueSet6 = [];
    Map<String, Timestamp> uniqueMap = {};
    for (var doc in documents) {
      String data1 = doc['area_name'];
      String data2 = doc['menu_name'];
      String data3 = doc['status'];
      String data4 = doc['store_name'];
      Timestamp data5 = doc['time'];
      String data6 = doc['tot_price'];
      uniqueSet1.add(data1);
      uniqueSet2.add(data2);
      uniqueSet3.add(data3);
      uniqueSet4.add(data4);
      uniqueSet5.add(data5);
      uniqueSet6.add(data6);
    }

    setState(() {
      uniqueData1 = uniqueSet1.toList();
      uniqueData2 = uniqueSet2.toList();
      uniqueData3 = uniqueSet3.toList();
      uniqueData4 = uniqueSet4.toList();
      uniqueData5 = uniqueSet5.toList();
      uniqueData6 = uniqueSet6.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xffAAC4FF),
            title: Text('주문내역',
                style: TextStyle(
                  color: Colors.black,
                )),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
                icon: Icon(Icons.arrow_back)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  width: MediaQuery.of(context).size.width,
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
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
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
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
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
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 20),
                      child: Text(
                        "진행중",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        height: MediaQuery.of(context).size.height - 70,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('testorder')
                              .where('userID', isEqualTo: _userID!.email)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> streamSnapshot) {
                            if (!streamSnapshot.hasData ||
                                streamSnapshot.data!.docs.isEmpty) {
                              return Container(); // 데이터가 없는 경우 처리
                            }
                            if (streamSnapshot.hasData) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: uniqueData1.length,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot documentSnapshot =
                                      streamSnapshot.data!.docs[index];
                                  String data1 = uniqueData1[index]; //area_name
                                  String data2 = uniqueData2[index]; //menu_name
                                  String data3 = uniqueData3[index]; //status
                                  String data4 =
                                      uniqueData4[index]; //store_name
                                  Timestamp data5 = uniqueData5[index]; //time
                                  String data6 = uniqueData6[index]; //tot_price
                                  Widget actionButton;
                                  if (data3 == '조리완료') {
                                    actionButton = ElevatedButton(
                                      onPressed: () async {
                                        String documentID = documentSnapshot.id;
                                        await FirebaseFirestore.instance
                                            .collection('testorder')
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
                                  } else {
                                    actionButton =
                                        SizedBox.shrink(); // 상태가 다른 경우 버튼을 숨김
                                  }
                                  if (searchText.isEmpty) {
                                    return Card(
                                      child: Container(
                                          height: 150,
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
                                                      alignment:
                                                          Alignment.center,
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
                                          )),
                                    );
                                  }
                                  if (data1.toString().contains(searchText) ||
                                      data5
                                          .toDate()
                                          .toString()
                                          .contains(searchText)) {
                                    return Card(
                                      child: Container(
                                        height: 150,
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
                                              width: 70,
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
    );
  }

  Color setColor(String status) {
    switch (status) {
      case '주문완료':
        return Colors.blueGrey;
      case '주문접수':
        return Colors.blue;
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
