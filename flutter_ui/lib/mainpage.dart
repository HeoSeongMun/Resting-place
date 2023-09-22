import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ui/menu.dart';
import 'package:flutter_ui/open_business.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  '현재 상태는?',
                                  style: TextStyle(
                                      fontFamily: "Jalnan", fontSize: 20),
                                ),
                                Text(
                                  '영업준비중!',
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
                              errorWidget: (context, url, error) => const Icon(
                                  Icons.error), // 에러 발생 시 표시될 위젯 설정 (선택사항)
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF99CCFF),
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
                                    '영업시작!',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 50),
                                  ),
                                  Text(
                                    '영업을 시작할시 누르세요!',
                                    style: TextStyle(
                                        fontFamily: "Jalnan", fontSize: 20),
                                  ),
                                ],
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fcook.gif?alt=media&token=62e97644-4866-45fc-b914-16289c80a1f4', // GIF 이미지의 URL을 여기에 입력
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
                                    '풀고있는 품목!',
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
                                    '리뷰조회',
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
                                    '매출조회',
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
