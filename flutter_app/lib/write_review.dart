import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReview extends StatefulWidget {
  WriteReview(this.areaName, this.storeName, this.menu, this.imageUrl,
      this.ordertime, this.storeUid);

  String storeName = '';
  String areaName = '';
  String menu = '';
  String imageUrl = '';
  Timestamp ordertime;
  String storeUid = '';
  String userName = '';

  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  String savedText = "";
  late double grade = 3;
  final TextEditingController reviewController = TextEditingController();

  final _userID = FirebaseAuth.instance.currentUser;
  CollectionReference product =
      FirebaseFirestore.instance.collection('testreviewlist');
  CollectionReference product1 =
      FirebaseFirestore.instance.collection('userinfo');
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  CollectionReference completecollection =
      FirebaseFirestore.instance.collection('complete');
  FocusNode _focusNode = FocusNode();

  _WriteReviewState() {
    reviewController.addListener(() {
      setState(() {
        savedText = reviewController.text;
      });
    });
  }
  Future<void> nameData() async {
    QuerySnapshot usersnapshot = await product1
        .where('userUid', isEqualTo: _userID!.uid.toString())
        .get();
    for (var doc in usersnapshot.docs) {
      widget.userName = doc['name'];
    }
    setState(() {});
  }

  Future<void> imageUrlData() async {
    QuerySnapshot imagesnapshot = await completecollection
        .where('storeName', isEqualTo: widget.storeName)
        .get();
    for (var doc in imagesnapshot.docs) {
      widget.imageUrl = doc['imageUrl'];
    }
    setState(() {});
  }

  Future<void> orderboolreviewUpdate() async {
    QuerySnapshot querySnapshot = await completecollection
        .where('area_name', isEqualTo: widget.areaName)
        .where('storeName', isEqualTo: widget.storeName)
        .where('name', isEqualTo: widget.menu)
        .where('ordertime', isEqualTo: widget.ordertime)
        .where('userUid', isEqualTo: _userID!.uid)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      for (QueryDocumentSnapshot document in documents) {
        String documentId = document.id;
        DocumentReference docRef = completecollection.doc(documentId);
        docRef.update({
          'boolreview': true, // 수정하려는 필드 이름과 새로운 값
        });
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    nameData();
    imageUrlData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'jalnan'),
      home: Scaffold(
        backgroundColor: Color(0xFFEEF1FF),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    top: 35,
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xFFD2DAFF),
                      borderRadius: BorderRadius.only(
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
                            Container(
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
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                            widget.areaName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                            widget.storeName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                            '음식 또는 매장에 대해 평가를 해주세요.',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 30,
                  child: Text(
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
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        grade = rating;
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 2,
                  color: Colors.black,
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 30,
                  child: Text(
                    '좋은점과 부족한점을 적어주세요.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: TextField(
                    controller: reviewController,
                    maxLines: 7,
                    decoration: InputDecoration(
                        hintText: '리뷰를 작성해주세요!',
                        hintStyle: TextStyle(
                          color: Colors.grey[300],
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                SizedBox(height: 50),
                ButtonTheme(
                    minWidth: 300,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (reviewController.text != '') {
                          savedText = reviewController.text;
                          await nameData();
                          await imageUrlData();
                          await product.add({
                            'name': widget.userName,
                            'area_name': widget.areaName,
                            'store_name': widget.storeName,
                            'menu': widget.menu,
                            'text': savedText,
                            'reviewtime': Timestamp.now(),
                            'ordertime': widget.ordertime,
                            'userUid': _userID!.uid.toString(),
                            'imageUrl': widget.imageUrl,
                            'storeUid': widget.storeUid,
                            'grade': grade,
                          });
                          await orderboolreviewUpdate();
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
                      child: Text('완 료'),
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
