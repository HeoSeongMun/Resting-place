// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/menu.dart';
import 'package:flutter_ui/review.dart';
import 'package:flutter_ui/sales.dart';
import 'package:intl/intl.dart';

class OpenBusiness extends StatelessWidget {
  OpenBusiness({super.key});
  final user = FirebaseAuth.instance.currentUser;

  CollectionReference product = FirebaseFirestore.instance.collection('order');
  CollectionReference complete =
      FirebaseFirestore.instance.collection('complete');
  CollectionReference sales = FirebaseFirestore.instance.collection('sales');

  DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999, 999);
  }

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
              SingleChildScrollView(
                child: Row(
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
                                color: const Color(0xFFF3C117),
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
                                          '현재 주문상태는?',
                                          style: TextStyle(
                                              fontFamily: "Jalnan",
                                              fontSize: 18),
                                        ),
                                        Text(
                                          '주문관리',
                                          style: TextStyle(
                                              fontFamily: "Jalnan",
                                              fontSize: 36),
                                        ),
                                      ],
                                    ),
                                    CachedNetworkImage(
                                      imageUrl:
                                          'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fpreparing.gif?alt=media&token=568425c7-e9fb-4ac0-a124-337af0f95baf', // GIF 이미지의 URL을 여기에 입력
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
                                        builder: (context) => OpenBusiness(),
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
                                              fontFamily: "Jalnan",
                                              fontSize: 27),
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
                            Row(
                              children: [
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
                                                topLeft: Radius.circular(
                                                    25.0), // 왼쪽 상단 모서리 굴곡
                                                bottomLeft: Radius.circular(
                                                    25.0), // 왼쪽 하단 모서리 굴곡
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(18),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: const [
                                                      Text(
                                                        '영업중',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 27),
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
                                                topLeft: Radius.circular(
                                                    25.0), // 왼쪽 상단 모서리 굴곡
                                                bottomLeft: Radius.circular(
                                                    25.0), // 왼쪽 하단 모서리 굴곡
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(18),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: const [
                                                      Text(
                                                        '준비중',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 27),
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
                                                bottomRight:
                                                    Radius.circular(25),
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
                                                      content: const Text(
                                                          '영업을 종료하시겠습니까?'),
                                                      actions: [
                                                        ElevatedButton(
                                                          child:
                                                              const Text('확인'),
                                                          onPressed: () async {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'testlogin')
                                                                .doc(documentSnapshot
                                                                    .id) // 문서의 ID
                                                                .update({
                                                              'status': false
                                                            }); // 원하는 업데이트
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                          child:
                                                              const Text('취소'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: const [
                                                        Text(
                                                          '영업종료',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Jalnan",
                                                              fontSize: 27,
                                                              color:
                                                                  Colors.white),
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
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(25),
                                                bottomRight:
                                                    Radius.circular(25),
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
                                                      content: const Text(
                                                          '영업을 시작하시겠습니까?'),
                                                      actions: [
                                                        ElevatedButton(
                                                          child:
                                                              const Text('확인'),
                                                          onPressed: () async {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'testlogin')
                                                                .doc(documentSnapshot
                                                                    .id) // 문서의 ID
                                                                .update({
                                                              'status': true
                                                            }); // 원하는 업데이트
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        OpenBusiness(),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                          child:
                                                              const Text('취소'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: const [
                                                        Text(
                                                          '영업시작',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Jalnan",
                                                              fontSize: 27),
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
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF8F9FE4),
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
                                      '주문받으세요~',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 18),
                                    ),
                                    Text(
                                      '접수하기',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 36),
                                    ),
                                  ],
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fnotifications.gif?alt=media&token=f86ba419-59fd-436f-a36b-91be0fde1e2c', // GIF 이미지의 URL을 여기에 입력
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
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFD2DAFF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          height: 500,
                          width: 305, //MediaQuery.of(context).size.width - 250,
                          child: Container(
                            child: StreamBuilder(
                              stream: product
                                  .where("storeUid", isEqualTo: user!.uid)
                                  .where("status", isEqualTo: "주문중")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${streamSnapshot.data!.docs.length}',
                                                    style: const TextStyle(
                                                        fontFamily: "Jalnan",
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount:
                                              streamSnapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            final DocumentSnapshot
                                                documentSnapshot =
                                                streamSnapshot
                                                    .data!.docs[index];
                                            DateTime now = DateTime.now();
                                            DateTime later10 = now.add(
                                                const Duration(minutes: 10));
                                            DateTime later20 = now.add(
                                                const Duration(minutes: 20));
                                            DateTime later30 = now.add(
                                                const Duration(minutes: 30));
                                            Timestamp timestamp =
                                                documentSnapshot['ordertime'];
                                            DateTime dateTime =
                                                timestamp.toDate();
                                            num totalprice = int.parse(
                                                    documentSnapshot['price']) *
                                                documentSnapshot['count'];
                                            return InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder: ((context) {
                                                    return AlertDialog(
                                                      title: const Text('승인'),
                                                      content: const Text(
                                                          '승인하시겠습니까?'),
                                                      actions: [
                                                        ElevatedButton(
                                                          child:
                                                              const Text('확인'),
                                                          onPressed: () async {
                                                            await sales.add({
                                                              'price':
                                                                  totalprice,
                                                              'storeUid':
                                                                  documentSnapshot[
                                                                      'storeUid'],
                                                              'time': FieldValue
                                                                  .serverTimestamp(),
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            return showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                title:
                                                                    const Text(
                                                                        '조리시간'),
                                                                actions: [
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await product
                                                                          .add(
                                                                        {
                                                                          'ordernumber':
                                                                              documentSnapshot['ordernumber'],
                                                                          'area_name':
                                                                              documentSnapshot['area_name'],
                                                                          'arrivalTime':
                                                                              documentSnapshot['arrivalTime'],
                                                                          'boolreview':
                                                                              false,
                                                                          'count':
                                                                              documentSnapshot['count'],
                                                                          'imageUrl':
                                                                              documentSnapshot['imageUrl'],
                                                                          'name':
                                                                              documentSnapshot['name'],
                                                                          'ordertime':
                                                                              documentSnapshot['ordertime'],
                                                                          'price':
                                                                              documentSnapshot['price'],
                                                                          'status':
                                                                              '조리중',
                                                                          'storeName':
                                                                              documentSnapshot['storeName'],
                                                                          'storeUid':
                                                                              documentSnapshot['storeUid'],
                                                                          'userUid':
                                                                              documentSnapshot['userUid'],
                                                                          'Cookingtime':
                                                                              later10,
                                                                          'time':
                                                                              FieldValue.serverTimestamp(),
                                                                          'totalprice':
                                                                              totalprice,
                                                                        },
                                                                      );
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'order')
                                                                          .doc(documentSnapshot
                                                                              .id)
                                                                          .delete();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: const Text(
                                                                        '10분'),
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await product
                                                                          .add(
                                                                        {
                                                                          'ordernumber':
                                                                              documentSnapshot['ordernumber'],
                                                                          'area_name':
                                                                              documentSnapshot['area_name'],
                                                                          'arrivalTime':
                                                                              documentSnapshot['arrivalTime'],
                                                                          'boolreview':
                                                                              false,
                                                                          'count':
                                                                              documentSnapshot['count'],
                                                                          'imageUrl':
                                                                              documentSnapshot['imageUrl'],
                                                                          'name':
                                                                              documentSnapshot['name'],
                                                                          'ordertime':
                                                                              documentSnapshot['ordertime'],
                                                                          'price':
                                                                              documentSnapshot['price'],
                                                                          'status':
                                                                              '조리중',
                                                                          'storeName':
                                                                              documentSnapshot['storeName'],
                                                                          'storeUid':
                                                                              documentSnapshot['storeUid'],
                                                                          'userUid':
                                                                              documentSnapshot['userUid'],
                                                                          'Cookingtime':
                                                                              later20,
                                                                          'time':
                                                                              FieldValue.serverTimestamp(),
                                                                          'totalprice':
                                                                              totalprice,
                                                                        },
                                                                      );
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'order')
                                                                          .doc(documentSnapshot
                                                                              .id)
                                                                          .delete();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: const Text(
                                                                        '20분'),
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await product
                                                                          .add(
                                                                        {
                                                                          'ordernumber':
                                                                              documentSnapshot['ordernumber'],
                                                                          'area_name':
                                                                              documentSnapshot['area_name'],
                                                                          'arrivalTime':
                                                                              documentSnapshot['arrivalTime'],
                                                                          'boolreview':
                                                                              false,
                                                                          'count':
                                                                              documentSnapshot['count'],
                                                                          'imageUrl':
                                                                              documentSnapshot['imageUrl'],
                                                                          'name':
                                                                              documentSnapshot['name'],
                                                                          'ordertime':
                                                                              documentSnapshot['ordertime'],
                                                                          'price':
                                                                              documentSnapshot['price'],
                                                                          'status':
                                                                              '조리중',
                                                                          'storeName':
                                                                              documentSnapshot['storeName'],
                                                                          'storeUid':
                                                                              documentSnapshot['storeUid'],
                                                                          'userUid':
                                                                              documentSnapshot['userUid'],
                                                                          'Cookingtime':
                                                                              later30,
                                                                          'time':
                                                                              FieldValue.serverTimestamp(),
                                                                          'totalprice':
                                                                              totalprice,
                                                                        },
                                                                      );
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'order')
                                                                          .doc(documentSnapshot
                                                                              .id)
                                                                          .delete();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: const Text(
                                                                        '30분'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                          child:
                                                              const Text('취소'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }),
                                                );
                                              },
                                              child: Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '주문번호 : ' +
                                                            documentSnapshot[
                                                                'ordernumber'],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Text(
                                                        '메뉴명 : ' +
                                                            documentSnapshot[
                                                                'name'],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        '가격 : ' +
                                                            documentSnapshot[
                                                                'price'],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        '수량 : ${documentSnapshot['count'].toString()}',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        '주문시간 : ${DateFormat('a h시 m분').format(dateTime)}',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Text(
                                                        '총가격 : $totalprice',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        '도착시간 : ' +
                                                            documentSnapshot[
                                                                'arrivalTime'],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFDF3D51),
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
                                      '현재 음식는?',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 18),
                                    ),
                                    Text(
                                      '조리중~',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 36),
                                    ),
                                  ],
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fcooking.gif?alt=media&token=7e9bd9e2-618e-4636-aeb3-6efff5fc0758', // GIF 이미지의 URL을 여기에 입력
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
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFD2DAFF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          height: 520,
                          width: 300, //MediaQuery.of(context).size.width - 250,
                          child: Container(
                            child: StreamBuilder(
                              stream: product
                                  .where("storeUid", isEqualTo: user!.uid)
                                  .where("status", isEqualTo: "조리중")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${streamSnapshot.data!.docs.length}',
                                                    style: const TextStyle(
                                                        fontFamily: "Jalnan",
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount:
                                              streamSnapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            final DocumentSnapshot
                                                documentSnapshot =
                                                streamSnapshot
                                                    .data!.docs[index];
                                            // 사용자 도착시간
                                            Timestamp ordertimestamp =
                                                documentSnapshot['ordertime'];
                                            DateTime orderdateTime =
                                                ordertimestamp.toDate();
                                            Timestamp cooktimestamp =
                                                documentSnapshot['Cookingtime'];
                                            DateTime cookdateTime =
                                                cooktimestamp.toDate();
                                            // 조리시작시간
                                            Timestamp timestamp =
                                                documentSnapshot['time'];
                                            DateTime dateTime =
                                                ordertimestamp.toDate();
                                            // 총가격 계산
                                            num totalprice = int.parse(
                                                    documentSnapshot['price']) *
                                                documentSnapshot['count'];
                                            return InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder: ((context) {
                                                    return AlertDialog(
                                                      title: const Text('조리완료'),
                                                      content: const Text(
                                                          '조리완료 하시겠습니까?'),
                                                      actions: [
                                                        ElevatedButton(
                                                          child:
                                                              const Text('확인'),
                                                          onPressed: () async {
                                                            await complete.add(
                                                              {
                                                                'ordernumber':
                                                                    documentSnapshot[
                                                                        'ordernumber'],
                                                                'area_name':
                                                                    documentSnapshot[
                                                                        'area_name'],
                                                                'arrivalTime':
                                                                    documentSnapshot[
                                                                        'arrivalTime'],
                                                                'boolreview':
                                                                    false,
                                                                'count':
                                                                    documentSnapshot[
                                                                        'count'],
                                                                'imageUrl':
                                                                    documentSnapshot[
                                                                        'imageUrl'],
                                                                'name':
                                                                    documentSnapshot[
                                                                        'name'],
                                                                'ordertime':
                                                                    documentSnapshot[
                                                                        'ordertime'],
                                                                'price':
                                                                    documentSnapshot[
                                                                        'price'],
                                                                'status': '완료',
                                                                'storeName':
                                                                    documentSnapshot[
                                                                        'storeName'],
                                                                'storeUid':
                                                                    documentSnapshot[
                                                                        'storeUid'],
                                                                'userUid':
                                                                    documentSnapshot[
                                                                        'userUid'],
                                                                'Cookingtime':
                                                                    '30분',
                                                                'time': FieldValue
                                                                    .serverTimestamp(),
                                                                'totalprice':
                                                                    documentSnapshot[
                                                                        'totalprice'],
                                                              },
                                                            );
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'order')
                                                                .doc(
                                                                    documentSnapshot
                                                                        .id)
                                                                .delete();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                          child:
                                                              const Text('취소'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }),
                                                );
                                              },
                                              child: Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '주분번호 : ' +
                                                            documentSnapshot[
                                                                'ordernumber'],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Text(
                                                        '메뉴명 : ' +
                                                            documentSnapshot[
                                                                'name'],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        '가격 : ' +
                                                            documentSnapshot[
                                                                'price'],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        '수량 : ${documentSnapshot['count'].toString()}',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        '주문시간 : ${DateFormat('a h시 m분').format(orderdateTime)}',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Text(
                                                        '총가격 : $totalprice',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        '시작시간 : ${DateFormat('a h시 m분').format(dateTime)}',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        '조리예상시간 : ${DateFormat('a h시 m분').format(cookdateTime)}',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        '도착시간 : ' +
                                                            documentSnapshot[
                                                                'arrivalTime'],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Jalnan",
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A363F),
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
                                      '오늘의 노력',
                                      style: TextStyle(
                                        fontFamily: "Jalnan",
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '조리완료!',
                                      style: TextStyle(
                                        fontFamily: "Jalnan",
                                        fontSize: 36,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fcheck.gif?alt=media&token=c5032a24-3575-486b-b5b5-2a9da5bbd135',
                                  width: 90,
                                  height: 90,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
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
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          height: 520,
                          width: 300,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: complete
                                .where("storeUid", isEqualTo: user!.uid)
                                .where("ordertime",
                                    isGreaterThanOrEqualTo: Timestamp.fromDate(
                                        DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day,
                                            0,
                                            0,
                                            0,
                                            0)),
                                    isLessThanOrEqualTo: Timestamp.fromDate(
                                        DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day,
                                            23,
                                            59,
                                            59,
                                            999,
                                            999)))
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (streamSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (streamSnapshot.hasError) {
                                print(streamSnapshot.error);
                                return Container();
                              } else if (!streamSnapshot.hasData ||
                                  streamSnapshot.data!.docs.isEmpty) {
                                print('데이터 없음');
                                return Container(); // 데이터가 없을 때의 처리
                              } else if (streamSnapshot.hasData) {
                                final List<DocumentSnapshot> sortedDocs =
                                    List.from(streamSnapshot.data!.docs);
                                sortedDocs.sort((a, b) {
                                  Timestamp timeA = a['ordertime'];
                                  Timestamp timeB = b['ordertime'];
                                  return timeB.compareTo(timeA);
                                });
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '${streamSnapshot.data!.docs.length}',
                                                  style: const TextStyle(
                                                      fontFamily: "Jalnan",
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: sortedDocs.length,
                                        itemBuilder: (context, index) {
                                          Timestamp timestamp =
                                              sortedDocs[index]['ordertime'];
                                          DateTime dateTime =
                                              timestamp.toDate();
                                          num totalprice = int.parse(
                                                  sortedDocs[index]['price']) *
                                              sortedDocs[index]['count'];
                                          return InkWell(
                                            child: Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '메뉴명 : ' +
                                                          sortedDocs[index]
                                                              ['name'],
                                                      style: const TextStyle(
                                                        fontFamily: "Jalnan",
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      '가격 : ' +
                                                          sortedDocs[index]
                                                              ['price'],
                                                      style: const TextStyle(
                                                        fontFamily: "Jalnan",
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      '수량 : ${sortedDocs[index]['count'].toString()}',
                                                      style: const TextStyle(
                                                        fontFamily: "Jalnan",
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      '주문시간 : ${DateFormat('a h시 m분').format(dateTime)}',
                                                      style: const TextStyle(
                                                        fontFamily: "Jalnan",
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    Text(
                                                      '총가격 : $totalprice',
                                                      style: const TextStyle(
                                                        fontFamily: "Jalnan",
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
