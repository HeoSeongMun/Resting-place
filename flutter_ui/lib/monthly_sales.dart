import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/mainpage.dart';
import 'package:flutter_ui/sales.dart';
import 'package:flutter_ui/specify_date.dart';
import 'package:flutter_ui/yearly_sales.dart';

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
          padding: const EdgeInsets.all(1),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFAAC4FF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 310,
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
                                    return TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black),
                                      child: Text(
                                        docs[index]['storeName'],
                                        style: const TextStyle(fontSize: 40),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainPage(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('testlogin')
                              .where("email", isEqualTo: user!.email)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
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
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD2DAFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 154,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('매출관리'),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            SizedBox(
                              height: 300,
                              width: 700,
                              child: BarChart(
                                BarChartData(
                                  titlesData: FlTitlesData(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}