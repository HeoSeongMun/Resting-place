import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewListPage extends StatelessWidget {
  ReviewListPage(this.storeName, {super.key});
  String storeName = "";
  CollectionReference product1 =
      FirebaseFirestore.instance.collection('testreviewlist');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffB1B2FF),
        title: Text('이용자 리뷰',
            style: TextStyle(
              color: Colors.black,
            )),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: StreamBuilder(
        stream: product1.where("store_name", isEqualTo: storeName).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                thickness: 3,
              ),
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                final Timestamp time = documentSnapshot['time'];
                final DateTime dateTime = time.toDate();
                return ListTile(
                  //contentPadding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                  title: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 30,
                              child: Text(
                                documentSnapshot['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              height: 20,
                              child: Text(
                                dateTime.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                documentSnapshot['text'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



/*class Review {
  final String userId;
  final String date;
  final String review;

  Review({required this.userId, required this.date, required this.review});
}

final List<Review> _reviewList = [
  Review(
    userId: 'Y J Sim',
    date: '2023-02-20',
    review: '국물이 얼큰해서 좋습니다.',
  ),
  Review(
    userId: 'S M Heo',
    date: '2023-02-20',
    review: '사장님이 친절하고 음식이 맛있네요',
  ),
  Review(
    userId: 'J H Ryu',
    date: '2023-02-20',
    review: '음식도 빨리나오고 양도 푸짐하니 좋아요',
  ),
  Review(
    userId: 'user_id_sample01',
    date: '2023-02-20',
    review:
        '글자수체크용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용용',
  ),
  Review(
    userId: 'user_id_sample02',
    date: '2023-02-20',
    review: '리뷰글!',
  ),
  Review(
    userId: 'user_id_sample03',
    date: '2023-02-20',
    review: '리뷰글!',
  ),
  Review(
    userId: 'user_id_sample04',
    date: '2023-02-20',
    review: '리뷰글!',
  ),
  Review(
    userId: 'user_id_sample05',
    date: '2023-02-20',
    review: '리뷰글!',
  ),
  Review(
    userId: 'user_id_sample06',
    date: '2023-02-20',
    review: '리뷰글!',
  ),
];*/
