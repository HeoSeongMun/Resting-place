import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/mainpage.dart';
import 'package:flutter_ui/add_image/add_image.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  final user = FirebaseAuth.instance.currentUser;
  String storeName = "";
  String subname = "";
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
          padding: const EdgeInsets.all(1),
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 가게 이름
                          SizedBox(
                            height: 60,
                            width: 290,
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
                                    storeName = docs[index]['storeName'];
                                    return TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black),
                                      child: Text(
                                        storeName,
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
                      // 휴게소 이름 + 방향
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
                                subname = docs[index]['restAreaName'] +
                                    '(' +
                                    docs[index]['direction'] +
                                    ')';
                                return Text(
                                  subname,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 97.5,
                      ),
                      child: Row(
                        children: const [
                          Text('메뉴관리'),
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
                        horizontal: 97.5,
                      ),
                      child: Row(
                        children: const [
                          Text('품절설정'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text('상품 이미지'),
                        GestureDetector(
                          onTap: () {
                            showAlert(context);
                          },
                          child: const Icon(Icons.image),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        SizedBox(
                          width: 240,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          width: 200,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xFF00226F),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Text(
                              '취소',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
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

                                // 플러터 웹 이미지 파이어베이스 스토리지 등록 4일 동안 개고생해서 해냄
                                final refImage = FirebaseStorage.instance
                                    .ref()
                                    .child(subname)
                                    .child(storeName)
                                    .child('$name.png');

                                await refImage.putData(userPickedImage!);

                                await product.add({
                                  'storeName': storeName,
                                  'name': name,
                                  'price': price,
                                  'soldout': false,
                                });
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
