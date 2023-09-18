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

  List<String> imageurlData = [];
  List<String> areaeData = [];
  List<String> storeData = [];
  List<String> menuData = [];
  List<String> textData = [];
  List<Timestamp> timeData = [];

  Future<void> fetchData() async {
    //시간순 정렬 함수
    QuerySnapshot snapshot =
        await reviewcollection.where('userUid', isEqualTo: user!.uid).get();
    List<DocumentSnapshot> documents = snapshot.docs;
    documents.sort((a, b) {
      Timestamp timeA = a['time'];
      Timestamp timeB = b['time'];
      return timeB.compareTo(timeA); // 정렬
    });
    List<String> imageurlList = [];
    List<String> areaeList = [];
    List<String> storeList = [];
    List<String> menuList = [];
    List<String> textList = [];
    List<Timestamp> timeList = [];

    for (var doc in documents) {
      String data1 = doc['imageUrl'].toString();
      String data2 = doc['area_name'];
      String data3 = doc['store_name'];
      String data4 = doc['menu'];
      String data5 = doc['text'];
      Timestamp data6 = doc['time'];
      imageurlList.add(data1);
      areaeList.add(data2);
      storeList.add(data3);
      menuList.add(data4);
      textList.add(data5);
      timeList.add(data6);
    }
    setState(() {
      imageurlData = imageurlList.toList();
      areaeData = areaeList.toList();
      storeData = storeList.toList();
      menuData = menuList.toList();
      textData = textList.toList();
      timeData = timeList.toList();
    });
  }

  void initState() {
    super.initState();
    fetchData();
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
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: imageurlData.length,
              itemBuilder: (context, index) {
                String data1 = imageurlData[index]; //imageUrl
                String data2 = areaeData[index]; //area_name
                String data3 = storeData[index]; //store_name
                String data4 = menuData[index]; //menu
                String data5 = textData[index]; //text
                Timestamp data6 = timeData[index];
                final DateTime dateTime = data6.toDate();
                String formattime =
                    DateFormat('yyyy-MM-dd').format(dateTime); //time
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0), // 여기서 간격 조절
                  leading: Image.network(data1),
                  title: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 15),
                    child: Text(
                      '휴게소 : ' + data2,
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '음식점 : ' + data3,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data4,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 50),
                        child: Text(
                          data5,
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
                                        data2, data3, data4, data1)),
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
                              streamSnapshot.data!.docs[index].reference
                                  .delete();
                              fetchData();
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
