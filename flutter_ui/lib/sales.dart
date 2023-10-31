import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/menu.dart';
import 'package:flutter_ui/monthly_sales.dart';
import 'package:flutter_ui/review.dart';
import 'package:flutter_ui/yearly_sales.dart';
import 'package:intl/intl.dart';

import 'open_business.dart';

class Sales extends StatefulWidget {
  const Sales({Key? key}) : super(key: key);

  @override
  _SalesState createState() => _SalesState();
}

DateTime? startDate; // 시작 날짜
DateTime? endDate; // 종료 날짜

class _SalesState extends State<Sales> {
  final user = FirebaseAuth.instance.currentUser;

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              100 /*왼*/, 30 /*위*/, 100 /*오른*/, 100 /*아래*/),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFAAC4FF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(27),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                            width: 1000,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('testlogin')
                                  .where("email", isEqualTo: user!.email)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                final docs = snapshot.data!.docs;
                                return ListView.builder(
                                  itemCount: docs.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: Text(
                                        docs[index]['storeName'],
                                        style: const TextStyle(
                                            fontFamily: "Jalnan", fontSize: 63),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 400,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('testlogin')
                                  .where("email", isEqualTo: user!.email)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                final docs = snapshot.data!.docs;
                                return ListView.builder(
                                  itemCount: docs.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Text(
                                          docs[index]['restAreaName'],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: "Jalnan",
                                              fontSize: 22),
                                        ),
                                        Text(
                                          '${'(' + docs[index]['direction']})',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: "Jalnan",
                                              fontSize: 22),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFAAC4FF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 27),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF827BE6),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(27),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: const [
                                      Text(
                                        '얼마나 벌었을까?',
                                        style: TextStyle(
                                            fontFamily: "Jalnan", fontSize: 18),
                                      ),
                                      Text(
                                        '매출관리',
                                        style: TextStyle(
                                            fontFamily: "Jalnan", fontSize: 36),
                                      ),
                                    ],
                                  ),
                                  CachedNetworkImage(
                                    imageUrl:
                                        'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fsales.gif?alt=media&token=0aa3a760-9f61-45a5-9762-bf41a2387ef1', // GIF 이미지의 URL을 여기에 입력
                                    width: 90, // 이미지의 가로 크기
                                    height: 90, // 이미지의 세로 크기
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(), // 로딩 중일 때 표시될 위젯 설정 (선택사항)
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons
                                            .error), // 에러 발생 시 표시될 위젯 설정 (선택사항)
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => OpenBusiness(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  // 글자크기 때문에 흰색 짤리면 수정
                                  horizontal: 100,
                                ),
                                child: Row(
                                  children: [
                                    Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/iconimage%2Forder.jpg?alt=media&token=7056226e-0f5b-4aa7-af66-6fd07879a341', // 이미지 URL 대체
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      '주문관리',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 27),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: InkWell(
                              onTap: () {
                                // 이동하고자 하는 페이지로 이동하는 코드를 작성합니다.
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Menu(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  // 글자크기 때문에 흰색 짤리면 수정
                                  horizontal: 100,
                                ),
                                child: Row(
                                  children: [
                                    Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/iconimage%2Fmenu.png?alt=media&token=de0a949e-d6cd-4ff3-953a-118ca66ef918', // 이미지 URL 대체
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      '메뉴관리',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 27),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: InkWell(
                              onTap: () {
                                // 이동하고자 하는 페이지로 이동하는 코드를 작성합니다.
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Review(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  // 글자크기 때문에 흰색 짤리면 수정
                                  horizontal: 100,
                                ),
                                child: Row(
                                  children: [
                                    Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/iconimage%2Freaview.png?alt=media&token=85827149-95c6-4acc-ab4f-e2e7f76062d6', // 이미지 URL 대체
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      '리뷰관리',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 27),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xFFAAC4FF),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(20.0), // 왼쪽 상단 모서리 굴곡
                                  bottomLeft:
                                      Radius.circular(20.0), // 왼쪽 하단 모서리 굴곡
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const Sales(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    // 글자크기 때문에 흰색 짤리면 수정
                                    horizontal: 115,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/iconimage%2Fsales.png?alt=media&token=a60dba24-f348-4274-ad68-455fb4c0ccbe', // 이미지 URL 대체
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        '매출관리',
                                        style: TextStyle(
                                            fontFamily: "Jalnan", fontSize: 27),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xFFD2DAFF),
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 80,
                            ),
                            child: Text(formattedDate),
                          ),
                        ),
                      ),
                      Container(
                        height: 2.0,
                        width: 240.0,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: const SizedBox(
                              width: 145,
                              child: Text(
                                '매출 구분',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: const SizedBox(
                              width: 100,
                              child: Text(
                                '매출',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 2.0,
                        width: 240.0,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: const SizedBox(
                              width: 145,
                              child: Text(
                                '일일 매출',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 5,
                            ),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('sales')
                                  .where('storeUid', isEqualTo: user!.uid)
                                  .where('time',
                                      isGreaterThanOrEqualTo: DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day),
                                      isLessThan: DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day)
                                          .add(const Duration(days: 1)))
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('Loading...');
                                }

                                // 'time'이 오늘인 데이터의 'price' 값을 더합니다.
                                for (var document in snapshot.data!.docs) {
                                  totalPrice += document['price'] as double;
                                }

                                // Container에 결과를 표시합니다.
                                return Container(
                                  child: Text('$totalPrice'),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 2.0,
                        width: 240.0,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: const SizedBox(
                              width: 145,
                              child: Text(
                                '이번달 매출',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 5,
                            ),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('sales')
                                  .where('storeUid', isEqualTo: user!.uid)
                                  .where('time',
                                      isGreaterThanOrEqualTo: DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          1))
                                  .where('time',
                                      isLessThan: DateTime(DateTime.now().year,
                                          DateTime.now().month + 1, 1))
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('Loading...');
                                }

                                double totalPrice = 0;

                                // 'time'이 이번 달인 데이터의 'price' 값을 더합니다.
                                for (var document in snapshot.data!.docs) {
                                  totalPrice += document['price'] as double;
                                }

                                // Container에 결과를 표시합니다.
                                return Container(
                                  child: Text('$totalPrice'),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 2.0,
                        width: 240.0,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: const SizedBox(
                              width: 145,
                              child: Text(
                                '이번년도 매출',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 5,
                            ),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('sales')
                                  .where('storeUid', isEqualTo: user!.uid)
                                  .where('time',
                                      isGreaterThanOrEqualTo:
                                          DateTime(DateTime.now().year, 1, 1))
                                  .where('time',
                                      isLessThan: DateTime(
                                          DateTime.now().year + 1, 1, 1))
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('Loading...');
                                }

                                double totalPrice = 0;

                                // 'time'이 이번 달인 데이터의 'price' 값을 더합니다.
                                for (var document in snapshot.data!.docs) {
                                  totalPrice += document['price'] as double;
                                }

                                // Container에 결과를 표시합니다.
                                return Container(
                                  child: Text('$totalPrice'),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xFFD2DAFF),
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 80,
                            ),
                            child: Text('날짜지정'),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          // 시작 날짜 선택 버튼
                          ElevatedButton(
                            onPressed: () async {
                              final selectedStartDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 5),
                                lastDate: DateTime.now(),
                              );
                              if (selectedStartDate != null) {
                                setState(() {
                                  startDate = selectedStartDate;
                                });
                              }
                            },
                            child: const Text('시작날짜'),
                          ),
                          // 종료 날짜 선택 버튼
                          const SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final selectedEndDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 5),
                                lastDate: DateTime.now(),
                              );
                              if (selectedEndDate != null) {
                                setState(() {
                                  endDate = selectedEndDate
                                      .add(const Duration(days: 1));
                                });
                              }
                            },
                            child: const Text('종료날짜'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // 선택한 날짜 사이의 'price' 값을 표시
                      if (startDate != null && endDate != null)
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('sales')
                              .where('storeUid', isEqualTo: user!.uid)
                              .where('time', isGreaterThanOrEqualTo: startDate)
                              .where('time', isLessThanOrEqualTo: endDate)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('Loading...');
                            }

                            double totalPrice = 0;

                            // 선택한 날짜 사이의 'price' 값을 더합니다.
                            for (var document in snapshot.data!.docs) {
                              totalPrice += document['price'] as double;
                            }

                            // Container에 결과를 표시합니다.
                            return Container(
                              child: Text('지정날짜매출 : $totalPrice원'),
                            );
                          },
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF2EA),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: InkWell(
                          onTap: () {
                            // 이동하고자 하는 페이지로 이동하는 코드를 작성합니다.
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Sales(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(27),
                            child: Row(
                              children: [
                                Column(
                                  children: const [
                                    Text(
                                      '간편매출',
                                      style: TextStyle(
                                        fontFamily: "Jalnan",
                                        fontSize: 36,
                                      ),
                                    ),
                                  ],
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/iconimage%2Fmoney2.gif?alt=media&token=b9857b49-8dfd-4df1-8f6b-e187e99410ad', // GIF 이미지의 URL을 여기에 입력
                                  width: 90, // 이미지의 가로 크기
                                  height: 90, // 이미지의 세로 크기
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(), // 로딩 중일 때 표시될 위젯 설정 (선택사항)
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons
                                          .error), // 에러 발생 시 표시될 위젯 설정 (선택사항)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF2EA),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: InkWell(
                          onTap: () {
                            // 이동하고자 하는 페이지로 이동하는 코드를 작성합니다.
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Monthlysales(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(27),
                            child: Row(
                              children: [
                                Column(
                                  children: const [
                                    Text(
                                      '월간매출',
                                      style: TextStyle(
                                        fontFamily: "Jalnan",
                                        fontSize: 36,
                                      ),
                                    ),
                                  ],
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/iconimage%2Fmoney2.gif?alt=media&token=b9857b49-8dfd-4df1-8f6b-e187e99410ad', // GIF 이미지의 URL을 여기에 입력
                                  width: 90, // 이미지의 가로 크기
                                  height: 90, // 이미지의 세로 크기
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(), // 로딩 중일 때 표시될 위젯 설정 (선택사항)
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons
                                          .error), // 에러 발생 시 표시될 위젯 설정 (선택사항)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF2EA),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: InkWell(
                          onTap: () {
                            // 이동하고자 하는 페이지로 이동하는 코드를 작성합니다.
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Yearlysales(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(27),
                            child: Row(
                              children: [
                                Column(
                                  children: const [
                                    Text(
                                      '연간매출',
                                      style: TextStyle(
                                        fontFamily: "Jalnan",
                                        fontSize: 36,
                                      ),
                                    ),
                                  ],
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/iconimage%2Fmoney2.gif?alt=media&token=b9857b49-8dfd-4df1-8f6b-e187e99410ad', // GIF 이미지의 URL을 여기에 입력
                                  width: 90, // 이미지의 가로 크기
                                  height: 90, // 이미지의 세로 크기
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(), // 로딩 중일 때 표시될 위젯 설정 (선택사항)
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons
                                          .error), // 에러 발생 시 표시될 위젯 설정 (선택사항)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
