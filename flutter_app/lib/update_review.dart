import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UpdateReview extends StatefulWidget {
  UpdateReview(this.areaName, this.storeName, this.menu, this.imageUrl,
      this.text, this.pasttime,
      {super.key});

  String areaName = '';
  String storeName = '';
  String menu = '';
  String imageUrl = '';
  String text = '';
  Timestamp pasttime;

  String userName = '';

  @override
  _UpdateReview createState() => _UpdateReview();
}

class _UpdateReview extends State<UpdateReview> {
  String savedText = "";
  late double grade = 0;
  late TextEditingController reviewController =
      TextEditingController(text: widget.text);
  final _userID = FirebaseAuth.instance.currentUser;
  CollectionReference product =
      FirebaseFirestore.instance.collection('testreviewlist');
  CollectionReference product1 =
      FirebaseFirestore.instance.collection('userinfo');
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');

  final FocusNode _focusNode = FocusNode();

  _WriteReviewState() {
    reviewController.addListener(() {
      setState(() {
        savedText = reviewController.text;
      });
    });
  }

  Future<void> gradeData() async {
    QuerySnapshot querySnapshot = await product
        .where('text', isEqualTo: widget.text)
        .where('area_name', isEqualTo: widget.areaName)
        .where('store_name', isEqualTo: widget.storeName)
        .where('menu', isEqualTo: widget.menu)
        .where('reviewtime', isEqualTo: widget.pasttime)
        .where('userUid', isEqualTo: _userID!.uid)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final String documentId = querySnapshot.docs[0].id;
      final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      setState(() {
        grade = double.parse(documentSnapshot['grade'].toString());
        print(grade);
      });
    }
  }

  Future<void> updateReviewText() async {
    QuerySnapshot querySnapshot = await product
        .where('text', isEqualTo: widget.text)
        .where('area_name', isEqualTo: widget.areaName)
        .where('store_name', isEqualTo: widget.storeName)
        .where('menu', isEqualTo: widget.menu)
        .where('reviewtime', isEqualTo: widget.pasttime)
        .where('userUid', isEqualTo: _userID!.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final String documentId = querySnapshot.docs[0].id;
      final DocumentReference docRef = product.doc(documentId);
      docRef.update({
        'text': savedText, // 수정하려는 필드 이름과 새로운 값
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gradeData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'jalnan'),
      home: Scaffold(
        backgroundColor: const Color(0xFFEEF1FF),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                    top: 35,
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD2DAFF),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5,
                          spreadRadius: 0,
                          offset: const Offset(0, 7),
                        ),
                      ]),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                iconSize: 25,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 40),
                          child: Text(
                            widget.areaName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 40),
                          child: Text(
                            widget.storeName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          margin: const EdgeInsets.only(left: 40),
                          child: const Text(
                            '음식 또는 매장에 대해 평가를 해주세요.',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 30,
                  child: const Text(
                    '서비스와 맛은 어땠었나요?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: RatingBar.builder(
                    initialRating: grade,
                    minRating: 1,
                    direction: Axis.horizontal,
                    ignoreGestures: true,
                    updateOnDrag: false,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (_) {},
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 2,
                  color: Colors.black,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 30,
                  child: const Text(
                    '좋은점과 부족한점을 적어주세요.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: TextField(
                    controller: reviewController,
                    maxLines: 7,
                    decoration: InputDecoration(
                        hintText: '리뷰를 작성해주세요!',
                        hintStyle: TextStyle(
                          color: Colors.grey[300],
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black12),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black12),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(height: 50),
                ButtonTheme(
                    minWidth: 300,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (reviewController.text != '') {
                          savedText = reviewController.text;
                          await updateReviewText();
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('리뷰를 작성해주세요!'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        }
                      },
                      child: const Text('완 료'),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }
}
