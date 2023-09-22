import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/mainpage.dart';
import 'package:flutter_ui/add_image/add_image.dart';
import 'package:flutter_ui/menu.dart';
import 'package:flutter_ui/open_business.dart';
import 'package:flutter_ui/review.dart';
import 'package:flutter_ui/sales.dart';

class Addmenu extends StatelessWidget {
  Addmenu({super.key});

  final user = FirebaseAuth.instance.currentUser;
  String storeName = "";
  String subname = "";
  //String restAreaName = "";
  CollectionReference product = FirebaseFirestore.instance.collection('menu');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // 테스트
  Future<void> update(DocumentSnapshot documentSnapshot) async {
    nameController.text = documentSnapshot['name'];
    priceController.text = documentSnapshot['price'];
  }

  // 테스트
  Future<void> create() async {}

  Uint8List? userPickedImage;

  void pickedImage(Uint8List image) {
    userPickedImage = image;
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: AddImage(pickedImage),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(100),
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // 이동하고자 하는 페이지로 이동하는 코드를 작성합니다.
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Menu(),
                          ),
                        );
                      },
                      child: Container(
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
                      width: 140,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3FFE2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: InkWell(
                        onTap: () {
                          // 이동하고자 하는 페이지로 이동하는 코드를 작성합니다.
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Addmenu(),
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
                                    '메뉴를 추가하세요!',
                                    style: TextStyle(
                                      fontFamily: "Jalnan",
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '메뉴추가',
                                    style: TextStyle(
                                      fontFamily: "Jalnan",
                                      fontSize: 50,
                                    ),
                                  ),
                                ],
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/gif%2Faddmenu.gif?alt=media&token=270c7f3c-98ff-4b76-a0fb-858f63513c29', // GIF 이미지의 URL을 여기에 입력
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
                      width: 140,
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
              Row(
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
                                            fontFamily: "Jalnan", fontSize: 30),
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
                    width: 100,
                  ),
                  SizedBox(
                    height: 580,
                    width: 500,
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text('메뉴명'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 2.0,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '메뉴명',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 2.0,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Text('가격'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: priceController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '가격',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 2.0,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text('상품 이미지'),
                            const SizedBox(
                              width: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                showAlert(context);
                              },
                              child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/test2-4def8.appspot.com/o/iconimage%2Fplus.jpg?alt=media&token=bdc65d4b-639f-4457-a17a-117185f8c6f1",
                                width: 250,
                                height: 250,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(
                              width: 100,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color(0xFF004DFD),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final String name = nameController.text;
                                    final String price = priceController.text;

                                    final refImage = FirebaseStorage.instance
                                        .ref()
                                        .child(subname)
                                        .child(storeName)
                                        .child('$name.png');

                                    await refImage.putData(userPickedImage!);
                                    final imageUrl =
                                        await refImage.getDownloadURL();

                                    await product.add(
                                      {
                                        //'areaName': restAreaName,
                                        'storeName': storeName,
                                        'name': name,
                                        'price': price,
                                        'soldout': false,
                                        'storeUid': user!.uid,
                                        'imageUrl': imageUrl,
                                      },
                                    );
                                    nameController.text = "";
                                    priceController.text = "";
                                  },
                                  child: const Text('추가'),
                                ),
                                /*Text(
                                '완료',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),*/
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
