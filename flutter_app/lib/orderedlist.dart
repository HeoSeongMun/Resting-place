import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderedList extends StatefulWidget {
  OrderedList({super.key});
  _OrderedList createState() => _OrderedList();
}

class _OrderedList extends State<OrderedList> {
  String _userID = "test1@naver.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffAAC4FF),
          title: Text('주문내역',
              style: TextStyle(
                color: Colors.black,
              )),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('testorder')
                        .where('userID', isEqualTo: _userID)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.separated(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];

                            Widget actionButton;
                            if (documentSnapshot['status'] == '조리완료') {
                              actionButton = ElevatedButton(
                                onPressed: () async {
                                  String documentID = documentSnapshot.id;
                                  await FirebaseFirestore.instance
                                      .collection('testorder')
                                      .doc(documentID)
                                      .update({'status': '완료'});
                                },
                                child: Text(
                                  '수령 완료',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff92ABEB),
                                ),
                              );
                            } else {
                              actionButton =
                                  SizedBox.shrink(); // 상태가 다른 경우 버튼을 숨김
                            }

                            return Container(
                                height: 150,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 150,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            height: 75,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    documentSnapshot[
                                                        'area_name'],
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text(
                                                  documentSnapshot['time']
                                                      .toDate()
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 75,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  documentSnapshot[
                                                      'store_name'],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                Text(
                                                  documentSnapshot['menu_name'],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                Text(
                                                  documentSnapshot[
                                                          'tot_price'] +
                                                      '원',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    Container(
                                      width: 60,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 15),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            color: setColor(
                                                documentSnapshot['status']),
                                            /*decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black)),*/
                                            child: Text(
                                              documentSnapshot['status'],
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(height: 5),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              '상세 주문',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: Colors.black),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xffAAC4FF),
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          actionButton,
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                          separatorBuilder: (context, index) => const Divider(
                            height: 10,
                            color: Colors.black,
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              )
            ],
          ),
        ));
  }

  Color setColor(String status) {
    switch (status) {
      case '주문완료':
        return Colors.blueGrey;
      case '주문접수':
        return Colors.blue;
      case '조리중':
        return Colors.yellow;
      case '조리완료':
        return Colors.green;
      case '완료':
        return Colors.grey;
      default:
        return Colors.white;
    }
  }
}
