import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/mainpage.dart';
import 'package:flutter_ui/menu.dart';
import 'package:flutter_ui/monthly_sales.dart';
import 'package:flutter_ui/open_business.dart';
import 'package:flutter_ui/review.dart';
import 'package:flutter_ui/sales.dart';
import 'package:flutter_ui/yearly_sales.dart';

class Specifydate extends StatefulWidget {
  const Specifydate({super.key});

  @override
  _SpecifydateState createState() => _SpecifydateState();
}

class _SpecifydateState extends State<Specifydate> {
  final user = FirebaseAuth.instance.currentUser;

  DateTime? startDate; // 시작 날짜
  DateTime? endDate; // 종료 날짜

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFAAC4FF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: InkWell(
                    onTap: () {
                      // 이동하고자 하는 페이지로 이동하는 코드를 작성합니다.
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 500,
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
                                              fontFamily: "Jalnan",
                                              fontSize: 50),
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
                                      return Text(
                                        docs[index]['restAreaName'] +
                                            '(' +
                                            docs[index]['direction'] +
                                            ')',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: "Jalnan", fontSize: 25),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFAAC4FF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100.0),
                      child: Column(
                        children: [
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
                                      '주문접수',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 30),
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
                                          fontFamily: "Jalnan", fontSize: 30),
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
                                      width: 53,
                                      height: 53,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      '리뷰조회',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 30),
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
                                            fontFamily: "Jalnan", fontSize: 30),
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
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 60,
                            horizontal: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.black),
                                child: const Text('간편매출보기'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Sales(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFD2DAFF),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 60,
                            horizontal: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.black),
                                child: const Text('월간매출'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Monthlysales(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFD2DAFF),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 60,
                            horizontal: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.black),
                                child: const Text('연간매출'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Yearlysales(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFD2DAFF),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 61,
                            horizontal: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.black),
                                child: const Text('날짜지정'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Specifydate(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Column(
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
                            // 선택한 날짜 사이의 'price' 값을 표시
                            if (startDate != null && endDate != null)
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('sales')
                                    .where('storeUid', isEqualTo: user!.uid)
                                    .where('time',
                                        isGreaterThanOrEqualTo: startDate)
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
                            SizedBox(
                              height: 300,
                              width: 700,
                              child: BarChart(
                                BarChartData(
                                  borderData: FlBorderData(
                                    border: const Border(
                                      top: BorderSide.none,
                                      right: BorderSide.none,
                                      left: BorderSide(width: 1),
                                      bottom: BorderSide(width: 1),
                                    ),
                                  ),
                                  groupsSpace: 10,
                                  barGroups: [
                                    BarChartGroupData(
                                      x: 1,
                                      barRods: [
                                        BarChartRodData(y: 100, width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 2,
                                      barRods: [
                                        BarChartRodData(y: 0, width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 3,
                                      barRods: [
                                        BarChartRodData(y: 0, width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 4,
                                      barRods: [
                                        BarChartRodData(y: 0, width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 5,
                                      barRods: [
                                        BarChartRodData(y: 0, width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 6,
                                      barRods: [
                                        BarChartRodData(y: 0, width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 7,
                                      barRods: [
                                        BarChartRodData(y: 0, width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 8,
                                      barRods: [
                                        BarChartRodData(y: 0, width: 15),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF050204),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: InkWell(
                          onTap: () {
                            // 이동하고자 하는 페이지로 이동하는 코드를 작성합니다.
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OpenBusiness(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              children: [
                                Column(
                                  children: const [
                                    Text(
                                      '간편매출',
                                      style: TextStyle(
                                          fontFamily: "Jalnan",
                                          fontSize: 40,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '간단하게 매출을 살펴보자!',
                                      style: TextStyle(
                                          fontFamily: "Jalnan",
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '원하는 날짜까지!',
                                      style: TextStyle(
                                          fontFamily: "Jalnan",
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fend.gif?alt=media&token=da3c5b87-b0fd-458d-8ea5-d7e9071152ee', // GIF 이미지의 URL을 여기에 입력
                                  width: 100, // 이미지의 가로 크기
                                  height: 100, // 이미지의 세로 크기
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
                          color: const Color(0xFF050204),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: InkWell(
                          onTap: () {
                            // 이동하고자 하는 페이지로 이동하는 코드를 작성합니다.
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OpenBusiness(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Column(
                                    children: const [
                                      Text(
                                        '월간매출',
                                        style: TextStyle(
                                            fontFamily: "Jalnan",
                                            fontSize: 40,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '저번달에 얼마 벌었지?',
                                        style: TextStyle(
                                            fontFamily: "Jalnan",
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        ' 이번달은?',
                                        style: TextStyle(
                                            fontFamily: "Jalnan",
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fend.gif?alt=media&token=da3c5b87-b0fd-458d-8ea5-d7e9071152ee', // GIF 이미지의 URL을 여기에 입력
                                  width: 100, // 이미지의 가로 크기
                                  height: 100, // 이미지의 세로 크기
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
                          color: const Color(0xFF050204),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: InkWell(
                          onTap: () {
                            // 이동하고자 하는 페이지로 이동하는 코드를 작성합니다.
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OpenBusiness(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(27.0),
                                  child: Column(
                                    children: const [
                                      Text(
                                        '연간매출',
                                        style: TextStyle(
                                            fontFamily: "Jalnan",
                                            fontSize: 40,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '작년에 얼마 벌었지?',
                                        style: TextStyle(
                                            fontFamily: "Jalnan",
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '이번년도는?',
                                        style: TextStyle(
                                            fontFamily: "Jalnan",
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fend.gif?alt=media&token=da3c5b87-b0fd-458d-8ea5-d7e9071152ee', // GIF 이미지의 URL을 여기에 입력
                                  width: 100, // 이미지의 가로 크기
                                  height: 100, // 이미지의 세로 크기
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
