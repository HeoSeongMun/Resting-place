import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/menu.dart';
import 'package:flutter_ui/monthly_sales.dart';
import 'package:flutter_ui/open_business.dart';
import 'package:flutter_ui/review.dart';
import 'package:flutter_ui/sales.dart';
import 'package:intl/intl.dart';

class Yearlysales extends StatefulWidget {
  const Yearlysales({super.key});

  @override
  _YearlysalesState createState() => _YearlysalesState();
}

class _YearlysalesState extends State<Yearlysales> {
  final user = FirebaseAuth.instance.currentUser;

  int currentPage = 0; // 현재 페이지 번호
  int itemsPerPage = 8; // 페이지 당 표시할 항목 수

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
                                      width: 53,
                                      height: 53,
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
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Column(
                              children: [
                                // 선택한 연도의 'price' 값을 표시
                                Row(
                                  children: [
                                    // DropdownButton을 통한 연도 선택
                                    DropdownButton<int>(
                                      value: selectedYear,
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          selectedYear = newValue!;
                                        });
                                      },
                                      items:
                                          List<DropdownMenuItem<int>>.generate(
                                              5, (int index) {
                                        // 연도 범위 설정 (예: 최근 5년)
                                        return DropdownMenuItem<int>(
                                          value: DateTime.now().year - index,
                                          child: Text(
                                            '${DateTime.now().year - index}년',
                                            style: const TextStyle(
                                              fontFamily: "Jalnan",
                                              fontSize: 27,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('sales')
                                          .where('storeUid',
                                              isEqualTo: user!.uid)
                                          .where('time',
                                              isGreaterThanOrEqualTo:
                                                  DateTime(selectedYear, 1, 1))
                                          .where('time',
                                              isLessThan: DateTime(
                                                  selectedYear + 1, 1, 1))
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

                                        double totalPrice = 0;

                                        // 선택한 연도의 'price' 값을 더합니다.
                                        for (var document
                                            in snapshot.data!.docs) {
                                          totalPrice +=
                                              document['price'] as double;
                                        }

                                        // Container에 결과를 표시합니다.
                                        /*$selectedYear년*/
                                        return Container(
                                          child: Text(
                                            '도 매출 : $totalPrice원',
                                            style: const TextStyle(
                                              fontFamily: "Jalnan",
                                              fontSize: 27,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('sales')
                                        .where('storeUid', isEqualTo: user!.uid)
                                        .where('time',
                                            isGreaterThanOrEqualTo:
                                                DateTime(selectedYear, 1, 1))
                                        .where('time',
                                            isLessThan: DateTime(
                                                selectedYear + 1, 1, 1))
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
                                      final docs = snapshot.data!.docs;
                                      final columns = <DataColumn>[
                                        DataColumn(
                                            label: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50.0),
                                                child: const Text(
                                                  '금액',
                                                  style: TextStyle(
                                                    fontFamily: "Jalnan",
                                                    fontSize: 27,
                                                  ),
                                                ))),
                                        DataColumn(
                                            label: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 100.0),
                                                child: const Text(
                                                  '날짜',
                                                  style: TextStyle(
                                                    fontFamily: "Jalnan",
                                                    fontSize: 27,
                                                  ),
                                                ))),
                                        // 필요한 열을 추가할 수 있습니다.
                                      ];
                                      // DataTable에 사용할 행 데이터 구성
                                      const pageSize = 10; // 페이지당 행 수를 설정하세요.
                                      final pageCount =
                                          (docs.length / pageSize).ceil();

                                      int currentPage = 0;

                                      final rows = docs
                                          .skip(currentPage * pageSize)
                                          .take(pageSize)
                                          .map((doc) {
                                        final data =
                                            doc.data() as Map<String, dynamic>;
                                        final Timestamp time = data['time'];
                                        final DateTime dateTime = time.toDate();
                                        String formattime =
                                            DateFormat('yyyy-MM-dd - HH시mm분')
                                                .format(dateTime);
                                        double totalPrice = 0;

                                        // 선택한 연도의 'price' 값을 더합니다.
                                        for (var document
                                            in snapshot.data!.docs) {
                                          totalPrice +=
                                              document['price'] as double;
                                        }
                                        return DataRow(
                                          cells: <DataCell>[
                                            DataCell(Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50.0),
                                              child: Text(
                                                data['price'].toString(),
                                                style: const TextStyle(
                                                  fontFamily: "Jalnan",
                                                  fontSize: 17,
                                                ),
                                              ),
                                            )),
                                            DataCell(Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            100.0), // 가로 간격을 조절
                                                child: Text(
                                                  formattime.toString(),
                                                  style: const TextStyle(
                                                    fontFamily: "Jalnan",
                                                    fontSize: 17,
                                                  ),
                                                ))),
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
                        ],
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
