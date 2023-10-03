import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/mainpage.dart';
import 'package:flutter_ui/menu.dart';
import 'package:flutter_ui/open_business.dart';
import 'package:flutter_ui/review.dart';
import 'package:flutter_ui/sales.dart';
import 'package:flutter_ui/yearly_sales.dart';
import 'package:intl/intl.dart';

class Monthlysales extends StatefulWidget {
  const Monthlysales({super.key});

  @override
  _MonthlysalesState createState() => _MonthlysalesState();
}

final user = FirebaseAuth.instance.currentUser;
//월별 데이터
Future<List<Map<String, dynamic>>> fetchData() async {
  List<Map<String, dynamic>> dataList = [];

  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('sales')
          .where('storeUid', isEqualTo: user!.uid)
          .orderBy('time') // time 필드를 기준으로 정렬
          .get();

  for (QueryDocumentSnapshot<Map<String, dynamic>> document
      in querySnapshot.docs) {
    // 각 문서에서 time과 price 필드 가져오기
    DateTime time = (document['time'] as Timestamp).toDate();
    double price = document['price'] as double;

    // 날짜를 월별로 변환 (예: 2023-09 -> 2023-09)
    String formattedMonth =
        '${time.year}-${time.month.toString().padLeft(2, '0')}';

    // 데이터를 Map에 저장
    Map<String, dynamic> data = {
      'month': formattedMonth,
      'price': price,
    };

    dataList.add(data);
  }

  return dataList;
}

Map<String, double> calculateMonthlyTotal(List<Map<String, dynamic>> dataList) {
  Map<String, double> monthlyTotal = {};

  for (Map<String, dynamic> data in dataList) {
    String month = data['month'];
    double? price = data['price'] as double?;

    if (price != null) {
      if (monthlyTotal.containsKey(month)) {
        // 이미 해당 월의 데이터가 있으면 더하기
        monthlyTotal[month] = (monthlyTotal[month] ?? 0) + price;
      } else {
        // 해당 월의 데이터가 없으면 새로 만들기
        monthlyTotal[month] = price;
      }
    }
  }

  return monthlyTotal;
}

class _MonthlysalesState extends State<Monthlysales> {
  List<Map<String, dynamic>> dataList = [];
  Map<String, double> monthlyTotal = {};

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  // Firebase에서 데이터 가져와서 화면 업데이트하기
  void fetchDataFromFirebase() async {
    List<Map<String, dynamic>> data = await fetchData();
    setState(() {
      dataList = data;
      monthlyTotal = calculateMonthlyTotal(data);
    });
  }

  final user = FirebaseAuth.instance.currentUser;

  int selectedMonth = 1;

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
                                              fontFamily: "Jalnan",
                                              fontSize: 70),
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
                                                fontSize: 25),
                                          ),
                                          Text(
                                            '${'(' + docs[index]['direction']})',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: "Jalnan",
                                                fontSize: 25),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Column(
                          children: [
                            // DropdownButton을 통한 월 선택
                            DropdownButton<int>(
                              value: selectedMonth,
                              onChanged: (int? newValue) {
                                setState(() {
                                  selectedMonth = newValue!;
                                });
                              },
                              items: List<DropdownMenuItem<int>>.generate(12,
                                  (int index) {
                                return DropdownMenuItem<int>(
                                  value: index + 1,
                                  child: Text('${index + 1} 월'),
                                );
                              }),
                            ),
                            // 선택한 달의 'price' 값을 표시
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('sales')
                                  .where('storeUid', isEqualTo: user!.uid)
                                  .where('time',
                                      isGreaterThanOrEqualTo: DateTime(
                                          DateTime.now().year,
                                          selectedMonth,
                                          1))
                                  .where('time',
                                      isLessThan: DateTime(DateTime.now().year,
                                          selectedMonth + 1, 1))
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

                                // 선택한 달의 'price' 값을 더합니다.
                                for (var document in snapshot.data!.docs) {
                                  totalPrice += document['price'] as double;
                                }

                                // Container에 결과를 표시합니다.
                                return Container(
                                  child: Text(
                                      '$selectedMonth 월 달 매출: $totalPrice원'),
                                );
                              },
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 50, right: 50),
                              height: 300,
                              width: 700,
                              decoration: const BoxDecoration(
                                color: Color(0xFFC5DFF8),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('sales')
                                          .where('storeUid',
                                              isEqualTo: user!.uid)
                                          .where('time',
                                              isGreaterThanOrEqualTo: DateTime(
                                                  DateTime.now().year,
                                                  selectedMonth,
                                                  1))
                                          .where('time',
                                              isLessThan: DateTime(
                                                  DateTime.now().year,
                                                  selectedMonth + 1,
                                                  1))
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text('Loading...');
                                        }
                                        final docs = snapshot.data!.docs;
                                        final columns = <DataColumn>[
                                          const DataColumn(label: Text('금액')),
                                          const DataColumn(label: Text('날짜')),
                                          // 필요한 열을 추가할 수 있습니다.
                                        ];
                                        // DataTable에 사용할 행 데이터 구성
                                        final rows = docs.map((doc) {
                                          final data = doc.data()
                                              as Map<String, dynamic>;
                                          final Timestamp time = data['time'];
                                          final DateTime dateTime =
                                              time.toDate();
                                          String formattime =
                                              DateFormat('yyyy-MM-dd - HH시mm분')
                                                  .format(dateTime);
                                          double totalPrice = 0;

                                          // 선택한 달의 'price' 값을 더합니다.
                                          for (var document
                                              in snapshot.data!.docs) {
                                            totalPrice +=
                                                document['price'] as double;
                                          }
                                          return DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text(
                                                  data['price'].toString())),
                                              DataCell(
                                                  Text(formattime.toString())),
                                              // 필요한 셀을 추가하거나 수정할 수 있습니다.
                                            ],
                                          );
                                        }).toList();
                                        return DataTable(
                                            columns: columns, rows: rows);
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              width: 700,
                              child: BarChart(
                                BarChartData(
                                  titlesData: FlTitlesData(
                                    topTitles: SideTitles(
                                      showTitles: false, // 윗면 숫자 숨기기
                                    ),
                                    leftTitles: SideTitles(
                                      showTitles: true,
                                      getTitles: (double value) {
                                        if (value >= 1000) {
                                          if (value >= 100000) {
                                            // 100,000 이상의 금액은 "십만"으로 표기
                                            return '${value ~/ 10000}만';
                                          } else {
                                            // 10,000 이상의 금액은 "만"으로 표기
                                            return '${value ~/ 10000}만';
                                          }
                                        }
                                        return value.toStringAsFixed(
                                            0); // 10,000 미만의 금액은 그대로 표기
                                      },
                                      reservedSize: 30, // 왼쪽면에 텍스트의 여백을 조절
                                    ),
                                    rightTitles: SideTitles(
                                      showTitles: false, // 오른쪽면 숫자 숨기기
                                    ),
                                    bottomTitles: SideTitles(
                                      showTitles: true,
                                      getTitles: (double value) {
                                        switch (value.toInt()) {
                                          case 0:
                                            return "1월";
                                          case 1:
                                            return "2월";
                                          case 2:
                                            return "3월";
                                          case 3:
                                            return "4월";
                                          case 4:
                                            return "5월";
                                          case 5:
                                            return "6월";
                                          case 6:
                                            return "7월";
                                          case 7:
                                            return "8월";
                                          case 8:
                                            return "9월";
                                          case 9:
                                            return "10월";
                                          case 10:
                                            return "11월";
                                          case 11:
                                            return "12월";
                                          default:
                                            return "";
                                        }
                                      },
                                    ),
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  barGroups: [
                                    BarChartGroupData(
                                      x: 0, // 1월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-01'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 1, // 2월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-02'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 2, // 3월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-03'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 3, // 4월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-04'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 4, // 5월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-05'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 5, // 6월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-06'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 6, // 7월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-07'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 7, // 8월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-08'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 8, // 9월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-09'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 9, // 10월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-10'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 10, // 11월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-11'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 11, // 12월 데이터
                                      barRods: [
                                        BarChartRodData(
                                            y: monthlyTotal['2023-12'] ?? 0,
                                            width: 15),
                                      ],
                                    ),
                                    // 나머지 월에 대한 데이터 설정...
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
                                builder: (context) => const Sales(),
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
                                builder: (context) => const Monthlysales(),
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
                                      '월간매출',
                                      style: TextStyle(
                                          fontFamily: "Jalnan",
                                          fontSize: 40,
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
                                builder: (context) => const Yearlysales(),
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
                                      '연간매출',
                                      style: TextStyle(
                                          fontFamily: "Jalnan",
                                          fontSize: 40,
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
