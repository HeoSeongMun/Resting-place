import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/mainpage.dart';
import 'package:flutter_ui/menu.dart';
import 'package:flutter_ui/review.dart';
import 'package:flutter_ui/sales.dart';

class OpenBusiness extends StatelessWidget {
  OpenBusiness({super.key});
  final user = FirebaseAuth.instance.currentUser;

  CollectionReference product = FirebaseFirestore.instance.collection('order');
  CollectionReference process =
      FirebaseFirestore.instance.collection('process');

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
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  '현제 상태는?',
                                  style: TextStyle(
                                      fontFamily: "Jalnan", fontSize: 20),
                                ),
                                Text(
                                  '영업중!',
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
                      width: 775,
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
                              Column(
                                children: const [
                                  Text(
                                    '영업종료',
                                    style: TextStyle(
                                        fontFamily: "Jalnan",
                                        fontSize: 50,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '영업을 종료할시 누르세요!',
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
              SingleChildScrollView(
                child: Row(
                  children: [
                    SizedBox(
                      height: 700,
                      child: Container(
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
                                            '주문접수',
                                            style: TextStyle(
                                                fontFamily: "Jalnan",
                                                fontSize: 30),
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
                                              fontFamily: "Jalnan",
                                              fontSize: 30),
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
                                          '리뷰조회',
                                          style: TextStyle(
                                              fontFamily: "Jalnan",
                                              fontSize: 30),
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
                                          '매출조회',
                                          style: TextStyle(
                                              fontFamily: "Jalnan",
                                              fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
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
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: const [
                                    Text(
                                      '주문받으세요~',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 13),
                                    ),
                                    Text(
                                      '접수하기',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 40),
                                    ),
                                  ],
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fnotifications.gif?alt=media&token=f86ba419-59fd-436f-a36b-91be0fde1e2c', // GIF 이미지의 URL을 여기에 입력
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
                        Container(
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          height: 520,
                          width: 300, //MediaQuery.of(context).size.width - 250,
                          color: const Color(0xFFD2DAFF),
                          child: Container(
                            child: StreamBuilder(
                              stream: product
                                  .where("storeUid", isEqualTo: user!.uid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: streamSnapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot =
                                          streamSnapshot.data!.docs[index];
                                      return Card(
                                        child: ListTile(
                                          title: Text(
                                            documentSnapshot['name'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Text(
                                            documentSnapshot['price'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: ((context) {
                                                return AlertDialog(
                                                  title: const Text('승인'),
                                                  content:
                                                      const Text('승인하시겠습니까?'),
                                                  actions: [
                                                    ElevatedButton(
                                                      child: const Text('확인'),
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        return showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                '조리시간'),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await process
                                                                      .add(
                                                                    {
                                                                      'storeName':
                                                                          documentSnapshot[
                                                                              'storeName'],
                                                                      'name': documentSnapshot[
                                                                          'name'],
                                                                      'price':
                                                                          documentSnapshot[
                                                                              'price'],
                                                                      'storeUid':
                                                                          documentSnapshot[
                                                                              'storeUid'],
                                                                      'userUid':
                                                                          documentSnapshot[
                                                                              'userUid'],
                                                                      'Cookingtime':
                                                                          '10분',
                                                                      'time': FieldValue
                                                                          .serverTimestamp(),
                                                                      'status':
                                                                          '조리중',
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
                                                                child:
                                                                    const Text(
                                                                        '10분'),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await process
                                                                      .add(
                                                                    {
                                                                      'storeName':
                                                                          documentSnapshot[
                                                                              'storeName'],
                                                                      'name': documentSnapshot[
                                                                          'name'],
                                                                      'price':
                                                                          documentSnapshot[
                                                                              'price'],
                                                                      'storeUid':
                                                                          documentSnapshot[
                                                                              'storeUid'],
                                                                      'userUid':
                                                                          documentSnapshot[
                                                                              'userUid'],
                                                                      'Cookingtime':
                                                                          '20분',
                                                                      'time': FieldValue
                                                                          .serverTimestamp(),
                                                                      'status':
                                                                          '조리중',
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
                                                                child:
                                                                    const Text(
                                                                        '20분'),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await process
                                                                      .add(
                                                                    {
                                                                      'storeName':
                                                                          documentSnapshot[
                                                                              'storeName'],
                                                                      'name': documentSnapshot[
                                                                          'name'],
                                                                      'price':
                                                                          documentSnapshot[
                                                                              'price'],
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
                                                                      'status':
                                                                          '조리중',
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
                                                                child:
                                                                    const Text(
                                                                        '30분'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                      child: const Text('취소'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      );
                                    },
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
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: const [
                                    Text(
                                      '현재 음식는?',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 13),
                                    ),
                                    Text(
                                      '조리중~',
                                      style: TextStyle(
                                          fontFamily: "Jalnan", fontSize: 40),
                                    ),
                                  ],
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fcooking.gif?alt=media&token=7e9bd9e2-618e-4636-aeb3-6efff5fc0758', // GIF 이미지의 URL을 여기에 입력
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
                        Container(
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          height: 520,
                          width: 300, //MediaQuery.of(context).size.width - 250,
                          color: const Color(0xFFD2DAFF),
                          child: Container(
                            child: StreamBuilder(
                              stream: product
                                  .where("storeUid", isEqualTo: user!.uid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: streamSnapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot =
                                          streamSnapshot.data!.docs[index];
                                      return Card(
                                        child: ListTile(
                                          title: Text(
                                            documentSnapshot['name'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Text(
                                            documentSnapshot['price'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: ((context) {
                                                return AlertDialog(
                                                  title: const Text('승인'),
                                                  content:
                                                      const Text('승인하시겠습니까?'),
                                                  actions: [
                                                    ElevatedButton(
                                                      child: const Text('확인'),
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        return showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                '조리시간'),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await process
                                                                      .add(
                                                                    {
                                                                      'storeName':
                                                                          documentSnapshot[
                                                                              'storeName'],
                                                                      'name': documentSnapshot[
                                                                          'name'],
                                                                      'price':
                                                                          documentSnapshot[
                                                                              'price'],
                                                                      'storeUid':
                                                                          documentSnapshot[
                                                                              'storeUid'],
                                                                      'userUid':
                                                                          documentSnapshot[
                                                                              'userUid'],
                                                                      'Cookingtime':
                                                                          '10분',
                                                                      'time': FieldValue
                                                                          .serverTimestamp(),
                                                                      'status':
                                                                          '조리중',
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
                                                                child:
                                                                    const Text(
                                                                        '10분'),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await process
                                                                      .add(
                                                                    {
                                                                      'storeName':
                                                                          documentSnapshot[
                                                                              'storeName'],
                                                                      'name': documentSnapshot[
                                                                          'name'],
                                                                      'price':
                                                                          documentSnapshot[
                                                                              'price'],
                                                                      'storeUid':
                                                                          documentSnapshot[
                                                                              'storeUid'],
                                                                      'userUid':
                                                                          documentSnapshot[
                                                                              'userUid'],
                                                                      'Cookingtime':
                                                                          '20분',
                                                                      'time': FieldValue
                                                                          .serverTimestamp(),
                                                                      'status':
                                                                          '조리중',
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
                                                                child:
                                                                    const Text(
                                                                        '20분'),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await process
                                                                      .add(
                                                                    {
                                                                      'storeName':
                                                                          documentSnapshot[
                                                                              'storeName'],
                                                                      'name': documentSnapshot[
                                                                          'name'],
                                                                      'price':
                                                                          documentSnapshot[
                                                                              'price'],
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
                                                                      'status':
                                                                          '조리중',
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
                                                                child:
                                                                    const Text(
                                                                        '30분'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                      child: const Text('취소'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      );
                                    },
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
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: const [
                                    Text(
                                      '오늘의 노력',
                                      style: TextStyle(
                                          fontFamily: "Jalnan",
                                          fontSize: 13,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '조리완료!',
                                      style: TextStyle(
                                          fontFamily: "Jalnan",
                                          fontSize: 45,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Fcheck.gif?alt=media&token=c5032a24-3575-486b-b5b5-2a9da5bbd135', // GIF 이미지의 URL을 여기에 입력
                                  width: 120, // 이미지의 가로 크기
                                  height: 120, // 이미지의 세로 크기
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
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          height: 520,
                          width: 300, //MediaQuery.of(context).size.width - 250,
                          color: const Color(0xFFD2DAFF),
                          child: Container(
                            child: StreamBuilder(
                              stream: product
                                  .where("storeUid", isEqualTo: user!.uid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: streamSnapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot =
                                          streamSnapshot.data!.docs[index];
                                      return Card(
                                        child: ListTile(
                                          title: Text(
                                            documentSnapshot['name'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Text(
                                            documentSnapshot['price'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: ((context) {
                                                return AlertDialog(
                                                  title: const Text('승인'),
                                                  content:
                                                      const Text('승인하시겠습니까?'),
                                                  actions: [
                                                    ElevatedButton(
                                                      child: const Text('확인'),
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        return showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                '조리시간'),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await process
                                                                      .add(
                                                                    {
                                                                      'storeName':
                                                                          documentSnapshot[
                                                                              'storeName'],
                                                                      'name': documentSnapshot[
                                                                          'name'],
                                                                      'price':
                                                                          documentSnapshot[
                                                                              'price'],
                                                                      'storeUid':
                                                                          documentSnapshot[
                                                                              'storeUid'],
                                                                      'userUid':
                                                                          documentSnapshot[
                                                                              'userUid'],
                                                                      'Cookingtime':
                                                                          '10분',
                                                                      'time': FieldValue
                                                                          .serverTimestamp(),
                                                                      'status':
                                                                          '조리중',
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
                                                                child:
                                                                    const Text(
                                                                        '10분'),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await process
                                                                      .add(
                                                                    {
                                                                      'storeName':
                                                                          documentSnapshot[
                                                                              'storeName'],
                                                                      'name': documentSnapshot[
                                                                          'name'],
                                                                      'price':
                                                                          documentSnapshot[
                                                                              'price'],
                                                                      'storeUid':
                                                                          documentSnapshot[
                                                                              'storeUid'],
                                                                      'userUid':
                                                                          documentSnapshot[
                                                                              'userUid'],
                                                                      'Cookingtime':
                                                                          '20분',
                                                                      'time': FieldValue
                                                                          .serverTimestamp(),
                                                                      'status':
                                                                          '조리중',
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
                                                                child:
                                                                    const Text(
                                                                        '20분'),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await process
                                                                      .add(
                                                                    {
                                                                      'storeName':
                                                                          documentSnapshot[
                                                                              'storeName'],
                                                                      'name': documentSnapshot[
                                                                          'name'],
                                                                      'price':
                                                                          documentSnapshot[
                                                                              'price'],
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
                                                                      'status':
                                                                          '조리중',
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
                                                                child:
                                                                    const Text(
                                                                        '30분'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                      child: const Text('취소'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
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
