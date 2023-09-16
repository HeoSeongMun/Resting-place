import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/write_review.dart';

class ReviewManagementScreen extends StatelessWidget {
  ReviewManagementScreen({super.key});

  CollectionReference usercollection =
      FirebaseFirestore.instance.collection('userinfo');
  CollectionReference reviewcollection =
      FirebaseFirestore.instance.collection('testreviewlist');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffB1B2FF),
        title: const Text('리뷰관리',
            style: TextStyle(
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: 10, //샘플데이터, 추후에 수정 요함!!!!
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          //샘플데이터, 추후에 수정 요함!!!!
          final reviewText = '$index 번째 리뷰';
          final date = '2022.02.22';
          //주문했었던 메뉴 이미지 띄우면 됨!!
          final image = Image.network(
              'https://www.shutterstock.com/ko/blog/wp-content/uploads/sites/17/2018/11/shutterstock_1068672764.jpg');

          return ListTile(
            leading: image,
            title: Text(reviewText),
            subtitle: Text(date),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WriteReview()),
                    );
                    */
                    // 수정 버튼
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // 삭제 버튼
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
