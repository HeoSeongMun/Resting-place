import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';

class PayComplete extends StatefulWidget {
  PayComplete(this.total, this.discount, this.finalprice, this.saveMileage,
      this.ordertime,
      {super.key});
  String total = '';
  int discount = 0;
  int finalprice = 0;
  int saveMileage = 0;
  Timestamp ordertime;
  @override
  State<PayComplete> createState() => _PayComplete();
}

class _PayComplete extends State<PayComplete> {
  final _userID = FirebaseAuth.instance.currentUser;
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  CollectionReference cartcollection =
      FirebaseFirestore.instance.collection('shoppingBasket');

  int cartcount = 0;
  int ordercount = 0;
  late bool isLoading = true;
  @override
  void initState() {
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
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
                            'assets/images/ingappicon4.gif'), // 로딩 인디케이터
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '...로딩중...',
                        style: TextStyle(fontFamily: 'jalnan'),
                      )
                    ],
                  ),
                ),
              )
            : SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //color: Colors.red,
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 50),
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        'assets/images/dollar.gif',
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Container(
                      //color: Colors.red,
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 15),
                      width: 350,
                      child: Text(
                        '총${widget.saveMileage}원이 마일리지로',
                        style: const TextStyle(
                          fontSize: 20.0, // 글자 크기
                          color: Colors.black, // 색상
                          letterSpacing: 3.0,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      //color: Colors.red,
                      child: const Text(
                        "적립되었습니다!",
                        style: TextStyle(
                          fontSize: 20.0, // 글자 크기
                          fontWeight: FontWeight.bold, // 볼드체
                          color: Colors.black, // 색상
                          letterSpacing: 3.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      color: Colors.black,
                      height: 5,
                      width: 340,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 25),
                        //color: Colors.red,
                        width: 340,
                        child: const Text("결제정보",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ))),
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      color: Colors.black26,
                      height: 2,
                      width: 340,
                    ),
                    Container(
                      width: 340,
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: const [
                              Text(
                                "주문금액",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 180,
                          ),
                          Column(
                            children: [
                              Text(
                                '${widget.total}원',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 45,
                      width: 340,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD2DAFF),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(left: 10, top: 15),
                              child: const Text(
                                "총 마일리지 할인 금액",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(top: 15, right: 15),
                              child: Text(
                                '${widget.discount}원',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFD2DAFF),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      height: 150,
                      width: 340,
                      margin: const EdgeInsets.only(top: 10),
                      child: StreamBuilder(
                        stream: ordercollection
                            .where('userUid', isEqualTo: _userID!.uid)
                            .where('ordertime',
                                isEqualTo: widget.ordertime.toDate())
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> streamSnapshot) {
                          if (streamSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            // 로딩 상태 처리
                            return const CircularProgressIndicator();
                          }
                          if (streamSnapshot.hasError) {
                            // 에러 처리
                            return Text('Error: ${streamSnapshot.error}');
                          }
                          if (!streamSnapshot.hasData ||
                              streamSnapshot.data!.docs.isEmpty) {
                            debugPrint('데이터가 없습니다.');
                            print(streamSnapshot.data!.docs);
                          }

                          if (streamSnapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final List<DocumentSnapshot> sortedDocs =
                                    List.from(streamSnapshot.data!.docs);
                                sortedDocs.sort((a, b) {
                                  String timeA = a['ordernumber'];
                                  String timeB = b['ordernumber'];
                                  return timeA.compareTo(timeB);
                                });
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 180,
                                            child: Text(
                                              sortedDocs[index]['storeName']
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 80,
                                          ),
                                          const Text(
                                            '주문번호',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 180,
                                              child: Text(sortedDocs[index]
                                                      ['name']
                                                  .toString())),
                                          const SizedBox(
                                            width: 105,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(sortedDocs[index]
                                                    ['ordernumber']
                                                .toString()),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 20),
                      //color: Colors.red,
                      width: 340,
                      child: const Text(
                        "결제 금액",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      color: Colors.black26,
                      height: 2,
                      width: 340,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 20),
                        //color: Colors.red,
                        width: 340,
                        child: const Text("최종 결제 금액",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ))),
                    Container(
                        alignment: Alignment.topRight,
                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                        //color: Colors.red,
                        width: 340,
                        child: Text('${widget.finalprice}원',
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ))),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                          if (result != null) {
                            setState(() {
                              CartCount();
                              OrderCount();
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: double.infinity,
                          color: const Color(0xffFFB79E),
                          child: const Text(
                            "확인",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
    QuerySnapshot snapshot = await ordercollection
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
}
