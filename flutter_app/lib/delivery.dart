import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<StatefulWidget> createState() => _Delivery();
}

class _Delivery extends State<Delivery> {
  //유저아이디 받아오는거 기본생성자에 넣어둬야함
  final _userID = FirebaseAuth.instance.currentUser;
  List<dynamic> setOrder0 = [];
  List<dynamic> setOrder1 = [];
  List<dynamic> setOrder2 = [];
  List<dynamic> setOrder3 = [];
  List<dynamic> setOrder4 = [];

  @override
  void initState() {
    super.initState();
    getOrderStatus();
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
                height: 110,
                padding: const EdgeInsets.only(
                  top: 35,
                ),
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
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 60,
                        height: 60,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 35,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        child: const Text(
                          "주문현황",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              getOrderContainer(setOrder0),
              getOrderContainer(setOrder1),
              getOrderContainer(setOrder2),
              getOrderContainer(setOrder3),
              getOrderContainer(setOrder4),
            ],
          ),
        ),
      ),
    );
  }

  //주문 데이터 불러오기
  Future<void> getOrderStatus() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<dynamic> order0 = [];
    List<dynamic> order1 = [];
    List<dynamic> order2 = [];
    List<dynamic> order3 = [];
    List<dynamic> order4 = [];
    //userID = 4c4PTU6c7KPFnRBtHCJtU8HNJZC2
    QuerySnapshot querySnapshot = await firestore
        .collection('order')
        .where('userUid', isEqualTo: _userID!.uid)
        .where('status', isNotEqualTo: '완료')
        .get();

    int docCount = querySnapshot.docs.length;

    for (int i = 0; i < docCount; i++) {
      if (i == 0) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs[i];
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String areaName = data['area_name'];
        order0.add(areaName);
        String menuName = data['name'];
        order0.add(menuName);
        String orderTime = formatTimestamp(data['ordertime']);
        order0.add(orderTime);
        String price = (int.parse(data['price']) * data['count']).toString();
        order0.add(price);
        String status = data['status'];
        order0.add(status);
        String storeName = data['storeName'];
        order0.add(storeName);
        double indicatorValue = getProgressIndicator(data['status']);
        order0.add(indicatorValue);
        int count = data['count'];
        order0.add(count);
        bool isExpanded = false;
        order0.add(isExpanded);
        String ordernumber = data['ordernumber'];
        order0.add(ordernumber);
        final DateTime dateTime = data['Cookingtime'].toDate();
        String formattime = DateFormat('aa HH시mm분')
            .format(dateTime)
            .replaceAll("AM", "오전")
            .replaceAll("PM", "오후");
        order0.add(formattime);

        setState(() {
          setOrder0 = order0.toList();
        });
      } else if (i == 1) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs[i];
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String areaName = data['area_name'];
        order1.add(areaName);
        String menuName = data['name'];
        order1.add(menuName);
        String orderTime = formatTimestamp(data['ordertime']);
        order1.add(orderTime);
        String price = (int.parse(data['price']) * data['count']).toString();
        order1.add(price);
        String status = data['status'];
        order1.add(status);
        String storeName = data['storeName'];
        order1.add(storeName);
        double indicatorValue = getProgressIndicator(data['status']);
        order1.add(indicatorValue);
        int count = data['count'];
        order1.add(count);
        bool isExpanded = false;
        order1.add(isExpanded);
        String ordernumber = data['ordernumber'];
        order1.add(ordernumber);
        final DateTime dateTime = data['Cookingtime'].toDate();
        String formattime = DateFormat('aa HH시mm분')
            .format(dateTime)
            .replaceAll("AM", "오전")
            .replaceAll("PM", "오후");
        order1.add(formattime);
        setState(() {
          setOrder1 = order1.toList();
        });
      } else if (i == 2) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs[i];
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String areaName = data['area_name'];
        order2.add(areaName);
        String menuName = data['name'];
        order2.add(menuName);
        String orderTime = formatTimestamp(data['ordertime']);
        order2.add(orderTime);
        String price = (int.parse(data['price']) * data['count']).toString();
        order2.add(price);
        String status = data['status'];
        order2.add(status);
        String storeName = data['storeName'];
        order2.add(storeName);
        double indicatorValue = getProgressIndicator(data['status']);
        order2.add(indicatorValue);
        int count = data['count'];
        order2.add(count);
        bool isExpanded = false;
        order2.add(isExpanded);
        String ordernumber = data['ordernumber'];
        order2.add(ordernumber);
        final DateTime dateTime = data['Cookingtime'].toDate();
        String formattime = DateFormat('aa HH시mm분')
            .format(dateTime)
            .replaceAll("AM", "오전")
            .replaceAll("PM", "오후");
        order2.add(formattime);
        setState(() {
          setOrder2 = order2.toList();
        });
      } else if (i == 3) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs[i];
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String areaName = data['area_name'];
        order3.add(areaName);
        String menuName = data['name'];
        order3.add(menuName);
        String orderTime = formatTimestamp(data['ordertime']);
        order3.add(orderTime);
        String price = (int.parse(data['price']) * data['count']).toString();
        order3.add(price);
        String status = data['status'];
        order3.add(status);
        String storeName = data['storeName'];
        order3.add(storeName);
        double indicatorValue = getProgressIndicator(data['status']);
        order3.add(indicatorValue);
        int count = data['count'];
        order3.add(count);
        bool isExpanded = false;
        order3.add(isExpanded);
        String ordernumber = data['ordernumber'];
        order3.add(ordernumber);
        final DateTime dateTime = data['Cookingtime'].toDate();
        String formattime = DateFormat('aa HH시mm분')
            .format(dateTime)
            .replaceAll("AM", "오전")
            .replaceAll("PM", "오후");
        order3.add(formattime);
        setState(() {
          setOrder3 = order3.toList();
        });
      } else {
        DocumentSnapshot documentSnapshot = querySnapshot.docs[i];
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String areaName = data['area_name'];
        order4.add(areaName);
        String menuName = data['name'];
        order4.add(menuName);
        String orderTime = formatTimestamp(data['ordertime']);
        order4.add(orderTime);
        String price = (int.parse(data['price']) * data['count']).toString();
        order4.add(price);
        String status = data['status'];
        order4.add(status);
        String storeName = data['storeName'];
        order4.add(storeName);
        double indicatorValue = getProgressIndicator(data['status']);
        order4.add(indicatorValue);
        int count = data['count'];
        order4.add(count);
        bool isExpanded = false;
        order4.add(isExpanded);
        String ordernumber = data['ordernumber'];
        order4.add(ordernumber);
        final DateTime dateTime = data['Cookingtime'].toDate();
        String formattime = DateFormat('aa HH시mm분')
            .format(dateTime)
            .replaceAll("AM", "오전")
            .replaceAll("PM", "오후");
        order4.add(formattime);
        setState(() {
          setOrder4 = order4.toList();
        });
      }
    }
  }

  //TimeStamp형식의 주문일자를 문자열로 변형
  String formatTimestamp(Timestamp timestamp) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final formattedDateTime = dateFormat.format(
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
    return formattedDateTime;
  }

  //프로그레스바 값 설정
  double getProgressIndicator(String status) {
    switch (status) {
      case '주문중':
        return 0.33;
      case '조리중':
        return 0.66;
      case '조리완료':
        return 1.0;
      default:
        return 0.0;
    }
  }

//리니어인디케이터 및 주문건 상태 표시하는 컨테이너
  Widget getOrderContainer(List order) {
    if (order.isEmpty) {
      return const SizedBox();
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        decoration: BoxDecoration(
            color: const Color(0xFFD2DAFF),
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
            Container(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: order[1],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 17)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1.5,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        order[4], //주문 상태 표시
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      height: 15,
                      child: LinearProgressIndicator(
                        value: order[6],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xffFFB79E),
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            order[8] = !order[8]; // 텍스트 버튼을 누를 때마다 확장/접기 상태 변경
                          });
                        },
                        child: order[8]
                            ? const Text(
                                '▽ 주문정보 닫기 ▽',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black54),
                              )
                            : const Text(
                                '▽ 주문정보 열기 ▽',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black54),
                              ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: order[8] ? null : 0,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1.5,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Container(
                              width: MediaQuery.of(context).size.width - 200,
                              margin: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                          const TextSpan(
                                            text: '주문 일자 :  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          TextSpan(
                                              text: order[2],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ]),
                                      )),
                                  const SizedBox(height: 10),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                          const TextSpan(
                                              text: '휴게소 명 :  ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: order[0],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ]),
                                      )),
                                  const SizedBox(height: 10),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                          const TextSpan(
                                              text: '점포 명 :  ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: order[5],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ]),
                                      )),
                                  const SizedBox(height: 10),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                          const TextSpan(
                                              text: '메뉴 이름 :  ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: order[1],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: '   ${order[7]}개',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ]),
                                      )),
                                  const SizedBox(height: 10),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                          const TextSpan(
                                              text: '주문 금액 :  ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: order[3] + ' ',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          const TextSpan(
                                              text: '원',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ]),
                                      )),
                                  const SizedBox(height: 10),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                          const TextSpan(
                                              text: '주문 번호 :  ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: order[9] + ' ',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ]),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Column(
                                  children: [
                                    Container(
                                      child: const Center(
                                        child: Text(
                                          '조리완료\n예상시간',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      child: Center(
                                        child: Text(
                                          order[10],
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            const SizedBox(width: 20)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
