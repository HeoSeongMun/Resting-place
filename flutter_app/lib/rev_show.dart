import 'package:flutter/material.dart';

class ReviewListPage extends StatelessWidget {
  const ReviewListPage({super.key});
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
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 3,
        ),
        itemCount: _reviewList.length,
        itemBuilder: (context, index) {
          return ListTile(
            //contentPadding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            title: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Text(
                          '유저 ID : ' + _reviewList[index].userId,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        child: Text(
                          _reviewList[index].date,
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
                        height: 70,
                        child: Text(
                          _reviewList[index].review,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Review {
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
];
