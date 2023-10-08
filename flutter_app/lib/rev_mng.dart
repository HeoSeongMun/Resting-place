import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/update_review.dart';
import 'package:flutter_app/write_review.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ReviewManagementScreen extends StatefulWidget {
  ReviewManagementScreen({super.key});
  _ReviewManagementScreen createState() => _ReviewManagementScreen();
}

class _ReviewManagementScreen extends State<ReviewManagementScreen> {
  CollectionReference usercollection =
      FirebaseFirestore.instance.collection('userinfo');
  CollectionReference reviewcollection =
      FirebaseFirestore.instance.collection('testreviewlist');
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  CollectionReference completecollection =
      FirebaseFirestore.instance.collection('complete');
  final user = FirebaseAuth.instance.currentUser;
  late bool isLoading = true; // 데이터가 로딩 중인지 여부를 나타내는 변수

  void initState() {
    isLoading = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'jalnan'),
      home: Scaffold(
        backgroundColor: Color(0xFFEEF1FF),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 110,
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
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 60,
                            height: 60,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              iconSize: 35,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Container(
                            child: Text(
                              "리뷰 관리",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3.7),
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                child: Image.asset(
                                    'assets/images/ingappicon3.gif'), // 로딩 인디케이터
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('...로딩중...')
                            ],
                          ),
                        )
                      : Container(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Color(0xFFC5DFF8),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
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
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: StreamBuilder(
                              stream: reviewcollection
                                  .where('userUid', isEqualTo: user!.uid)
                                  .snapshots(),
                              builder: (BuildContext context, streamSnapshot) {
                                if (streamSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox();
                                }
                                if (!streamSnapshot.hasData ||
                                    streamSnapshot.data!.docs.isEmpty) {
                                  return Container(
                                      child: Text(
                                          '작성한 리뷰가 없습니다!')); // 데이터가 없는 경우 처리
                                }
                                if (streamSnapshot.hasData) {
                                  isLoading = false;
                                  final List<DocumentSnapshot> sortedDocs =
                                      List.from(streamSnapshot.data!.docs);
                                  sortedDocs.sort((a, b) {
                                    Timestamp timeA = a['reviewtime'];
                                    Timestamp timeB = b['reviewtime'];
                                    return timeB.compareTo(timeA);
                                  });
                                  return ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      color: Colors.grey,
                                      thickness: 3,
                                    ),
                                    itemCount: sortedDocs.length,
                                    itemBuilder: (context, index) {
                                      Timestamp data6 =
                                          sortedDocs[index]['reviewtime'];
                                      final DateTime dateTime = data6.toDate();
                                      String formattime =
                                          DateFormat('yyyy-MM-dd')
                                              .format(dateTime);
                                      return ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0), // 여기서 간격 조절
                                        leading: Image.network(
                                            sortedDocs[index]['imageUrl']),
                                        title: Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 15),
                                          child: Text(
                                            sortedDocs[index]['area_name'],
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                sortedDocs[index]['store_name'],
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                sortedDocs[index]['menu'],
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              child: RatingBar.builder(
                                                initialRating: double.parse(
                                                    sortedDocs[index]['grade']
                                                        .toString()),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                ignoreGestures: true,
                                                updateOnDrag: false,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemSize: 15,
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (_) {},
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin:
                                                  EdgeInsets.only(bottom: 50),
                                              child: Text(
                                                sortedDocs[index]['text'],
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                formattime,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 35,
                                                height: 30,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            UpdateReview(
                                                                sortedDocs[
                                                                        index][
                                                                    'area_name'],
                                                                sortedDocs[
                                                                        index][
                                                                    'store_name'],
                                                                sortedDocs[
                                                                        index]
                                                                    ['menu'],
                                                                sortedDocs[
                                                                        index][
                                                                    'imageUrl'],
                                                                sortedDocs[
                                                                        index]
                                                                    ['text'],
                                                                sortedDocs[
                                                                        index][
                                                                    'reviewtime']),
                                                      ),
                                                    );
                                                    // 수정 버튼
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                  ),
                                                  onPressed: () async {
                                                    sortedDocs[index]
                                                        .reference
                                                        .delete();
                                                    // 리뷰삭제 및 complete컬렉션 boolreview 필드 값 변경 버튼
                                                    QuerySnapshot querySnapshot = await completecollection
                                                        .where('area_name',
                                                            isEqualTo: sortedDocs[
                                                                    index]
                                                                ['area_name'])
                                                        .where('storeName',
                                                            isEqualTo: sortedDocs[
                                                                    index]
                                                                ['store_name'])
                                                        .where('name',
                                                            isEqualTo:
                                                                sortedDocs[index]
                                                                    ['menu'])
                                                        .where('ordertime',
                                                            isEqualTo: sortedDocs[
                                                                    index]
                                                                ['ordertime'])
                                                        .where('userUid',
                                                            isEqualTo: user!.uid)
                                                        .get();

                                                    if (querySnapshot
                                                        .docs.isNotEmpty) {
                                                      List<QueryDocumentSnapshot>
                                                          documents =
                                                          querySnapshot.docs;
                                                      for (QueryDocumentSnapshot document
                                                          in documents) {
                                                        String documentId =
                                                            document.id;
                                                        DocumentReference
                                                            docRef =
                                                            completecollection
                                                                .doc(
                                                                    documentId);
                                                        docRef.update({
                                                          'boolreview':
                                                              false, // 수정하려는 필드 이름과 새로운 값
                                                        });
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        isThreeLine: true,
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
            ),
          ],
        ),
      ),
    );
  }
}
