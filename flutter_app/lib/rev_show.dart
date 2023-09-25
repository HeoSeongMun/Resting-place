import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewListPage extends StatelessWidget {
  ReviewListPage(this.storeName, {super.key});
  String storeName = "";
  CollectionReference product1 =
      FirebaseFirestore.instance.collection('testreviewlist');

  List<DocumentSnapshot> documents = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'jalnan'),
      home: Scaffold(
        backgroundColor: Color(0xFFEEF1FF),
        body: SingleChildScrollView(
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
                          "리뷰",
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
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                    stream: product1
                        .where("store_name", isEqualTo: storeName)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (!streamSnapshot.hasData ||
                          streamSnapshot.data!.docs.isEmpty) {
                        return Container(
                            child: Text('리뷰가 없습니다')); // 데이터가 없는 경우 처리
                      }
                      if (streamSnapshot.hasData) {
                        documents = streamSnapshot.data!.docs;
                        documents.sort((a, b) {
                          Timestamp timeA = a['reviewtime'];
                          Timestamp timeB = b['reviewtime'];
                          return timeB.compareTo(timeA); // 정렬
                        });
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                            thickness: 3,
                          ),
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            final Timestamp time =
                                documents[index]['reviewtime'];
                            final DateTime dateTime = time.toDate();
                            String formattime =
                                DateFormat('yyyy-MM-dd - HH시mm분')
                                    .format(dateTime);
                            return ListTile(
                              //contentPadding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                              title: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  documents[index]['name'],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RichText(
                                      overflow: TextOverflow.clip,
                                      maxLines: 10,
                                      strutStyle: StrutStyle(fontSize: 13),
                                      text: TextSpan(
                                        text: documents[index]['text'],
                                        style: TextStyle(
                                          fontFamily: 'jalnan',
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Text(
                                          formattime.toString(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                    ],
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
