import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/write_review.dart';
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

  final user = FirebaseAuth.instance.currentUser;

  void initState() {
    super.initState();
  }

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: StreamBuilder(
        stream:
            reviewcollection.where('userUid', isEqualTo: user!.uid).snapshots(),
        builder: (BuildContext context, streamSnapshot) {
          if (!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty) {
            return Container(); // 데이터가 없는 경우 처리
          }
          if (streamSnapshot.hasData) {
            final List<DocumentSnapshot> sortedDocs =
                List.from(streamSnapshot.data!.docs);
            sortedDocs.sort((a, b) {
              Timestamp timeA = a['time'];
              Timestamp timeB = b['time'];
              return timeB.compareTo(timeA);
            });
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: sortedDocs.length,
              itemBuilder: (context, index) {
                Timestamp data6 = sortedDocs[index]['time'];
                final DateTime dateTime = data6.toDate();
                String formattime = DateFormat('yyyy-MM-dd').format(dateTime);
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0), // 여기서 간격 조절
                  leading: Image.network(sortedDocs[index]['imageUrl']),
                  title: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 15),
                    child: Text(
                      '휴게소 : ' + sortedDocs[index]['area_name'],
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '음식점 : ' + sortedDocs[index]['store_name'],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          sortedDocs[index]['menu'],
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 50),
                        child: Text(
                          sortedDocs[index]['text'],
                          style: TextStyle(color: Colors.black),
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
                                    builder: (context) => WriteReview(
                                        sortedDocs[index]['area_name'],
                                        sortedDocs[index]['store_name'],
                                        sortedDocs[index]['menu'],
                                        sortedDocs[index]['imageUrl'])),
                              );
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
                              sortedDocs[index].reference.delete();
                              // 삭제 버튼
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
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
