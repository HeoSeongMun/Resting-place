import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<StatefulWidget> createState() => _Delivery();
}

class _Delivery extends State<Delivery> {
  //유저아이디 받아오는거 기본생성자에 넣어둬야함
  String userID = '4c4PTU6c7KPFnRBtHCJtU8HNJZC2';
  List<dynamic> setOrder0 = [];
  List<dynamic> setOrder1 = [];
  List<dynamic> setOrder2 = [];

  @override
  void initState() {
    super.initState();
    getOrderStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffAAC4FF),
        title: Text('주문 현황',
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
          children: [
            getOrderContainer(setOrder0),
            getOrderContainer(setOrder1),
            getOrderContainer(setOrder2),
          ],
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
    //userID = 4c4PTU6c7KPFnRBtHCJtU8HNJZC2
    QuerySnapshot querySnapshot = await firestore
        .collection('order')
        .where('userUid', isEqualTo: '4c4PTU6c7KPFnRBtHCJtU8HNJZC2')
        .get();

    int docCount = querySnapshot.docs.length;

    for (int i = 0; i < docCount; i++) {
      if (i == 0) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs[i];
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String area_name = data['area_name'];
        order0.add(area_name);
        String menu_name = data['name'];
        order0.add(menu_name);
        String order_time = formatTimestamp(data['ordertime']);
        order0.add(order_time);
        String price = data['price'];
        order0.add(price);
        String status = data['status'];
        order0.add(status);
        String store_name = data['storeName'];
        order0.add(store_name);
        double indicatorValue = getProgressIndicator(data['status']);
        order0.add(indicatorValue);
        if (status != '완료') {
          setState(() {
            setOrder0 = order0.toList();
          });
        }
      } else if (i == 1) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs[i];
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        order1.add(data['area_name']);
        order1.add(data['name']);
        order1.add(formatTimestamp(data['ordertime']));
        order1.add(data['price']);
        order1.add(data['status']);
        order1.add(data['storeName']);
        double indicatorValue = getProgressIndicator(data['status']);
        order1.add(indicatorValue);
        if (data['status'] != '완료') {
          setState(() {
            setOrder1 = order1.toList();
          });
        }
      } else {
        DocumentSnapshot documentSnapshot = querySnapshot.docs[i];
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        order2.add(data['area_name']);
        order2.add(data['name']);
        order2.add(formatTimestamp(data['ordertime']));
        order2.add(data['price']);
        order2.add(data['status']);
        order2.add(data['storeName']);
        double indicatorValue = getProgressIndicator(data['status']);
        order2.add(indicatorValue);
        if (data['status'] != '완료') {
          setState(() {
            setOrder2 = order2.toList();
          });
        }
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
      return SizedBox();
    } else {
      return Container(
        height: 300,
        color: Colors.yellow,
        child: Column(
          children: [
            Container(
              height: 120,
              color: Colors.blue,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        order[4], //주문 상태 표시
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    height: 20,
                    child: LinearProgressIndicator(
                      value: order[6],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  Container(
                    width: MediaQuery.of(context).size.width - 200,
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width - 200,
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: '주문 일자 :  ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: order[2]),
                              ]),
                            )),
                        const SizedBox(height: 10),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width - 200,
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                    text: '휴게소 명 :  ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: order[0]),
                              ]),
                            )),
                        const SizedBox(height: 10),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width - 200,
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: '점포 명 :  ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: order[5]),
                              ]),
                            )),
                        SizedBox(height: 10),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width - 200,
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: '메뉴 이름 :  ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: order[1]),
                              ]),
                            )),
                        SizedBox(height: 10),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width - 200,
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: '주문 금액 :  ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: order[3]),
                              ]),
                            )),
                      ],
                    ),
                  ),
                  Container(
                      child: Column(
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            '조리완료\n예상시간',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Center(
                          child: Text(
                            '오후 11시 30분',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                  SizedBox(width: 20)
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
