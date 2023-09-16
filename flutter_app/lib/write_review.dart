import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReview extends StatelessWidget {
  WriteReview(this.areaName, this.storeName, this.menu, this.imageUrl,
      {super.key});
  String storeName = '';
  String areaName = '';
  String menu = '';
  String imageUrl = '';
  String userName = '';

  final _userID = FirebaseAuth.instance.currentUser;
  CollectionReference product =
      FirebaseFirestore.instance.collection('testreviewlist');
  CollectionReference product1 =
      FirebaseFirestore.instance.collection('userinfo');
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  final TextEditingController reviewController = TextEditingController();
  FocusNode focusNode = FocusNode();

  Future<void> nameData() async {
    QuerySnapshot usersnapshot = await product1
        .where('userUid', isEqualTo: _userID!.uid.toString())
        .get();
    for (var doc in usersnapshot.docs) {
      userName = doc['name'];
    }
  }

  Future<void> imageUrlData() async {
    QuerySnapshot imagesnapshot =
        await ordercollection.where('storeName', isEqualTo: storeName).get();
    for (var doc in imagesnapshot.docs) {
      imageUrl = doc['imageUrl'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('리뷰쓰기',
                style: TextStyle(
                  color: Colors.black,
                )),
            centerTitle: true,
            backgroundColor: Color(0xffAAC4FF),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  color: Color(0xffAAC4FF),
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            areaName,
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
                          child: Text(
                            storeName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Text(
                            '음식 또는 매장에 대해 평가를 해주세요.',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 3,
                  color: Colors.blue,
                ),
                SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 30,
                  color: Color(0xffAAC4FF),
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
                        print(rating);
                      },
                    )),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 2,
                  color: Colors.black,
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 30,
                  color: Color(0xffAAC4FF),
                  child: Text(
                    '좋은점과 부족한점을 적어주세요.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: TextFormField(
                    focusNode: focusNode,
                    controller: reviewController,
                    maxLines: 7,
                    keyboardType: TextInputType.multiline,
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
                  ),
                ),
                SizedBox(height: 50),
                ButtonTheme(
                    minWidth: 300,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (reviewController.text != '') {
                          await nameData();
                          await imageUrlData();
                          /*Query query = product1.where('userUid',
                              isEqualTo: _userID!.uid.toString());
                          QuerySnapshot querySnapshot = await query.get();
                          
                          List<QueryDocumentSnapshot> documents =
                            querySnapshot.docs;
                          for (QueryDocumentSnapshot document in documents){

                          }*/
                          await product.add({
                            'name': userName,
                            'area_name': areaName,
                            'store_name': storeName,
                            'menu': menu,
                            'text': reviewController.text,
                            'time': Timestamp.now(),
                            'userUid': _userID!.uid.toString(),
                            'imageUrl': imageUrl,
                          });
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
          )),
    );
  }
}
