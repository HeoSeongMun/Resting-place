import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ui/menu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_ui/open_business.dart';
import 'package:flutter_ui/review.dart';
import 'package:flutter_ui/sales.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

final user = FirebaseAuth.instance.currentUser;

CollectionReference product = FirebaseFirestore.instance.collection('order');
CollectionReference process = FirebaseFirestore.instance.collection('process');

class _MainPageState extends State<MainPage> {
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3C117),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: const [
                                  Text(
                                    '현재 주문상태는?',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 20),
                                  ),
                                  Text(
                                    '주문관리',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 50),
                                  ),
                                ],
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fpreparing.gif?alt=media&token=568425c7-e9fb-4ac0-a124-337af0f95baf', // GIF 이미지의 URL을 여기에 입력
                                width: 200, // 이미지의 가로 크기
                                height: 150, // 이미지의 세로 크기
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
                      width: 100,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC5BB),
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
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: const [
                                  Text(
                                    '팔고있는 품목!',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 20),
                                  ),
                                  Text(
                                    '메뉴관리',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 50),
                                  ),
                                ],
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fmenu.gif?alt=media&token=d3be18db-e92e-4e6d-ba0e-368287987e1c', // GIF 이미지의 URL을 여기에 입력
                                width: 200, // 이미지의 가로 크기
                                height: 150, // 이미지의 세로 크기
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
                      width: 100,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF827BE6),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: const [
                                  Text(
                                    '얼마나 벌었을까?',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 20),
                                  ),
                                  Text(
                                    '매출관리',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 50),
                                  ),
                                ],
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fsales.gif?alt=media&token=0aa3a760-9f61-45a5-9762-bf41a2387ef1', // GIF 이미지의 URL을 여기에 입력
                                width: 200, // 이미지의 가로 크기
                                height: 150, // 이미지의 세로 크기
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
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
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
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            children: [
                              Column(
                                children: const [
                                  Text(
                                    '리뷰관리',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 50),
                                  ),
                                  Text(
                                    '고객님의 생각',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 20),
                                  ),
                                ],
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Freview.gif?alt=media&token=bc277960-ab53-4a31-a31f-7e497fd850c8', // GIF 이미지의 URL을 여기에 입력
                                width: 200, // 이미지의 가로 크기
                                height: 150, // 이미지의 세로 크기
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
                      width: 100,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('testlogin')
                          .where("storeUid", isEqualTo: user!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator(); // 데이터를 기다리는 동안 로딩 표시
                        }
                        QueryDocumentSnapshot documentSnapshot =
                            snapshot.data!.docs.first;
                        final status = documentSnapshot['status'];

                        return status
                            ? Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF3C117),
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(25.0), // 왼쪽 상단 모서리 굴곡
                                    bottomLeft:
                                        Radius.circular(25.0), // 왼쪽 하단 모서리 굴곡
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: const [
                                          Text(
                                            '영업중',
                                            style: TextStyle(
                                                fontFamily: "Jalnan",
                                                fontSize: 50),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF3C117),
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(25.0), // 왼쪽 상단 모서리 굴곡
                                    bottomLeft:
                                        Radius.circular(25.0), // 왼쪽 하단 모서리 굴곡
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: const [
                                          Text(
                                            '준비중',
                                            style: TextStyle(
                                                fontFamily: "Jalnan",
                                                fontSize: 50),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('testlogin')
                          .where("storeUid", isEqualTo: user!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator(); // 데이터를 기다리는 동안 로딩 표시
                        }
                        QueryDocumentSnapshot documentSnapshot =
                            snapshot.data!.docs.first;
                        final status = documentSnapshot['status'];

                        return status
                            ? Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFF050204),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: ((context) {
                                        return AlertDialog(
                                          title: const Text('영업종료'),
                                          content: const Text('영업을 종료하시겠습니까?'),
                                          actions: [
                                            ElevatedButton(
                                              child: const Text('확인'),
                                              onPressed: () async {
                                                FirebaseFirestore.instance
                                                    .collection('testlogin')
                                                    .doc(documentSnapshot
                                                        .id) // 문서의 ID
                                                    .update({
                                                  'status': false
                                                }); // 원하는 업데이트
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text('취소'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      }),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(30),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: const [
                                            Text(
                                              '영업종료',
                                              style: TextStyle(
                                                  fontFamily: "Jalnan",
                                                  fontSize: 50,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFF99CCFF),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: ((context) {
                                        return AlertDialog(
                                          title: const Text('영업시작'),
                                          content: const Text('영업을 시작하시겠습니까?'),
                                          actions: [
                                            ElevatedButton(
                                              child: const Text('확인'),
                                              onPressed: () async {
                                                FirebaseFirestore.instance
                                                    .collection('testlogin')
                                                    .doc(documentSnapshot
                                                        .id) // 문서의 ID
                                                    .update({
                                                  'status': true
                                                }); // 원하는 업데이트
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OpenBusiness(),
                                                  ),
                                                );
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text('취소'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      }),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(30),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: const [
                                            Text(
                                              '영업시작',
                                              style: TextStyle(
                                                  fontFamily: "Jalnan",
                                                  fontSize: 50),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
