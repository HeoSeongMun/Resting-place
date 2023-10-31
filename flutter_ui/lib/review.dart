import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/mainpage.dart';
import 'package:flutter_ui/menu.dart';
import 'package:flutter_ui/open_business.dart';
import 'package:flutter_ui/sales.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Review extends StatelessWidget {
  Review({super.key});

  final user = FirebaseAuth.instance.currentUser;
  CollectionReference reviewcollection =
      FirebaseFirestore.instance.collection('testreviewlist');

  final ScrollController _scrollController = ScrollController();
  late int gradescount = 0;
  late double averagegrade = 0;
  late int highgrade = 0;
  late String highmenu = '';
  late String lowmenu = '';
  late int lowgrade = 0;
  Future<void> averageData() async {
    // 가장 평점 및 리뷰 갯수 가져오기
    QuerySnapshot querySnapshot =
        await reviewcollection.where("storeUid", isEqualTo: user!.uid).get();
    int totalGrade = 0;
    int numberOfGrades = querySnapshot.docs.length;
    for (var doc in querySnapshot.docs) {
      int grade = doc['grade'];
      totalGrade += grade;
    }
    averagegrade = totalGrade / numberOfGrades;
    gradescount = numberOfGrades;
  }

  Future<void> highratingData() async {
    // 가장 높은  grade 값 문서 가져오기
    QuerySnapshot querySnapshot =
        await reviewcollection.where("storeUid", isEqualTo: user!.uid).get();
    final List<DocumentSnapshot> sortedDocs = List.from(querySnapshot.docs);
    sortedDocs.sort((a, b) {
      num timeA = a['grade'];
      num timeB = b['grade'];
      return timeB.compareTo(timeA);
    });
    highgrade = sortedDocs[0]['grade'];
    highmenu = sortedDocs[0]['menu'];
  }

  Future<void> lowratingData() async {
    // 가장 낮은 grade 값 문서 가져오기
    QuerySnapshot querySnapshot =
        await reviewcollection.where("storeUid", isEqualTo: user!.uid).get();
    final List<DocumentSnapshot> sortedDocs = List.from(querySnapshot.docs);
    sortedDocs.sort((a, b) {
      num timeA = a['grade'];
      num timeB = b['grade'];
      return timeA.compareTo(timeB);
    });
    lowgrade = sortedDocs[0]['grade'];
    lowmenu = sortedDocs[0]['menu'];
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          debugPrint('Scroll position at top');
        } else {
          debugPrint('Scroll position at bottom');
          // Load more list items
        }
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              100 /*왼*/, 30 /*위*/, 100 /*오른*/, 100 /*아래*/),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFAAC4FF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(30),
                              child: Row(
                                children: [
                                  Column(
                                    children: const [
                                      Text(
                                        '고객님의 생각',
                                        style: TextStyle(
                                            fontFamily: "Jalnan", fontSize: 20),
                                      ),
                                      Text(
                                        '리뷰관리',
                                        style: TextStyle(
                                            fontFamily: "Jalnan", fontSize: 40),
                                      ),
                                    ],
                                  ),
                                  CachedNetworkImage(
                                    imageUrl:
                                        'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Freview.gif?alt=media&token=bc277960-ab53-4a31-a31f-7e497fd850c8', // GIF 이미지의 URL을 여기에 입력
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
                                      builder: (context) => Menu(),
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
                                            fontFamily: "Jalnan", fontSize: 30),
                                      ),
                                    ],
                                  ),
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
                                    builder: (context) => const Sales(),
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
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/iconimage%2Fsales.png?alt=media&token=a60dba24-f348-4274-ad68-455fb4c0ccbe', // 이미지 URL 대체
                                      width: 53,
                                      height: 53,
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
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFC5DFF8),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                height: 520,
                                width: 600,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFC5DFF8),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                  ),
                                ),
                                child: StreamBuilder(
                                  stream: reviewcollection
                                      .where("storeUid", isEqualTo: user!.uid)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot>
                                          streamSnapshot) {
                                    final List<DocumentSnapshot> sortedDocs =
                                        List.from(streamSnapshot.data!.docs);
                                    sortedDocs.sort((a, b) {
                                      Timestamp timeA = a['reviewtime'];
                                      Timestamp timeB = b['reviewtime'];
                                      return timeB.compareTo(timeA);
                                    });
                                    if (streamSnapshot.hasData) {
                                      return ListView.builder(
                                        controller: _scrollController,
                                        itemCount: sortedDocs.length,
                                        itemBuilder: (context, index) {
                                          final Timestamp time =
                                              sortedDocs[index]['reviewtime'];
                                          final DateTime dateTime =
                                              time.toDate();
                                          String formattime =
                                              DateFormat('yyyy-MM-dd - HH시mm분')
                                                  .format(dateTime);
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 5),
                                                        child: Text(
                                                          sortedDocs[index]
                                                              ['name'],
                                                          style: const TextStyle(
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 10, top: 5),
                                                        child:
                                                            RatingBar.builder(
                                                          initialRating:
                                                              sortedDocs[index][
                                                                          'grade']
                                                                      .isNaN
                                                                  ? 0
                                                                  : sortedDocs[
                                                                          index]
                                                                      ['grade'],
                                                          minRating: 1,
                                                          direction:
                                                              Axis.horizontal,
                                                          ignoreGestures: true,
                                                          updateOnDrag: false,
                                                          allowHalfRating:
                                                              false,
                                                          itemCount: 5,
                                                          itemSize: 20,
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  const Icon(
                                                            Icons.star,
                                                            color: Color(
                                                                0xFFFF8F00),
                                                          ),
                                                          onRatingUpdate:
                                                              (_) {},
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Text(
                                                      '메뉴 :' +
                                                          sortedDocs[index]
                                                              ['menu'],
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: Text(
                                                      sortedDocs[index]['text'],
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 10,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            right: 10, top: 10),
                                                        child: Text(
                                                          formattime,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    height: 2,
                                                    color: Colors.black54,
                                                  ),
                                                ]),
                                          );
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
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3FFE2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: FutureBuilder(
                            future: averageData(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '현재 평점은?',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 30),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '평점 : $averagegrade',
                                    style: const TextStyle(
                                        fontFamily: "Jalnan", fontSize: 25),
                                  ),
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: averagegrade.isNaN
                                            ? 0
                                            : averagegrade,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        ignoreGestures: true,
                                        updateOnDrag: false,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: 30,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Color(0xFFFF8F00),
                                        ),
                                        onRatingUpdate: (_) {},
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 10, top: 4),
                                        child: Text(
                                          '( $gradescount )',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Jalnan"),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3FFE2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: FutureBuilder(
                            future: highratingData(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '최고의 리뷰!',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 30),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '메뉴 : $highmenu',
                                    style: const TextStyle(
                                        fontFamily: "Jalnan", fontSize: 25),
                                  ),
                                  RatingBar.builder(
                                    initialRating: highgrade.isNaN
                                        ? 0
                                        : highgrade.toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    ignoreGestures: true,
                                    updateOnDrag: false,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 30,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Color(0xFFFF8F00),
                                    ),
                                    onRatingUpdate: (_) {},
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3FFE2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: FutureBuilder(
                            future: lowratingData(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '최악의 리뷰ㅠㅠ',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 30),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '메뉴 : $lowmenu',
                                    style: const TextStyle(
                                        fontFamily: "Jalnan", fontSize: 25),
                                  ),
                                  RatingBar.builder(
                                    initialRating: lowgrade.isNaN
                                        ? 0
                                        : lowgrade.toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    ignoreGestures: true,
                                    updateOnDrag: false,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 30,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Color(0xFFFF8F00),
                                    ),
                                    onRatingUpdate: (_) {},
                                  ),
                                ],
                              );
                            },
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
