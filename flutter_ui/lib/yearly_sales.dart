import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/mainpage.dart';
import 'package:flutter_ui/monthly_sales.dart';
import 'package:flutter_ui/sales.dart';
import 'package:flutter_ui/specify_date.dart';

class Yearlysales extends StatefulWidget {
  const Yearlysales({super.key});

  @override
  _YearlysalesState createState() => _YearlysalesState();
}

class _YearlysalesState extends State<Yearlysales> {
  final user = FirebaseAuth.instance.currentUser;

  int selectedYear = DateTime.now().year; // 현재 연도로 기본 설정

  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  void fetchDataFromFirebase() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('sales')
        .where('storeUid', isEqualTo: user!.uid)
        .get();

    List<Map<String, dynamic>> data = querySnapshot.docs.map((doc) {
      // 문서에서 필요한 데이터 추출
      DateTime time = (doc['time'] as Timestamp).toDate();
      double price = doc['price'] as double;

      // 연도 추출
      int year = time.year;

      return {
        'year': year,
        'price': price,
      };
    }).toList();

    setState(() {
      dataList = data;
    });
  }

  Map<int, double> calculateYearlyTotal(List<Map<String, dynamic>> data) {
    Map<int, double> yearlyTotal = {};

    for (Map<String, dynamic> entry in data) {
      int year = entry['year'];
      double price = entry['price'];
      if (yearlyTotal.containsKey(year)) {
        yearlyTotal[year] = (yearlyTotal[year] ?? 0) + price;
      } else {
        yearlyTotal[year] = price;
      }
    }

    return yearlyTotal;
  }

  @override
  Widget build(BuildContext context) {
    Map<int, double> yearlyTotal = calculateYearlyTotal(dataList);
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
                            // DropdownButton을 통한 연도 선택
                            DropdownButton<int>(
                              value: selectedYear,
                              onChanged: (int? newValue) {
                                setState(() {
                                  selectedYear = newValue!;
                                });
                              },
                              items: List<DropdownMenuItem<int>>.generate(5,
                                  (int index) {
                                // 연도 범위 설정 (예: 최근 5년)
                                return DropdownMenuItem<int>(
                                  value: DateTime.now().year - index,
                                  child:
                                      Text('${DateTime.now().year - index}년'),
                                );
                              }),
                            ),
                            // 선택한 연도의 'price' 값을 표시
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('sales')
                                  .where('storeUid', isEqualTo: user!.uid)
                                  .where('time',
                                      isGreaterThanOrEqualTo:
                                          DateTime(selectedYear, 1, 1))
                                  .where('time',
                                      isLessThan:
                                          DateTime(selectedYear + 1, 1, 1))
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

                                // 선택한 연도의 'price' 값을 더합니다.
                                for (var document in snapshot.data!.docs) {
                                  totalPrice += document['price'] as double;
                                }

                                // Container에 결과를 표시합니다.
                                return Container(
                                  child:
                                      Text('$selectedYear년도 매출 : $totalPrice원'),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        width: 700,
                        child: BarChart(
                          BarChartData(
                            titlesData: FlTitlesData(
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTitles: (value) {
                                  // value는 연도를 나타냅니다.
                                  return value.toString();
                                },
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: yearlyTotal.entries.map((entry) {
                              int year = entry.key;
                              double sales = entry.value;
                              return BarChartGroupData(
                                x: year,
                                barRods: [
                                  BarChartRodData(
                                    y: sales,
                                    width: 15,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      )
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
