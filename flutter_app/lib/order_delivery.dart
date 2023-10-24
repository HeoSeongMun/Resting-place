import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/order_delivery_ListItem.dart';

class Orderdelivery extends StatefulWidget {
  Orderdelivery(
      this.areaName, this.storeName, this.menu, this.count, this.ordertime,
      {super.key});
  String areaName = '';
  String storeName = '';
  String menu = '';
  Timestamp ordertime;
  int count;
  @override
  State<StatefulWidget> createState() => _Orderdelivery();
}

class _Orderdelivery extends State<Orderdelivery> {
  final _userID = FirebaseAuth.instance.currentUser;
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'jalnan'),
      home: Scaffold(
        backgroundColor: const Color(0xFFEEF1FF),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                padding: const EdgeInsets.only(
                  top: 35,
                ),
                decoration: BoxDecoration(
                    color: const Color(0xFFD2DAFF),
                    borderRadius: const BorderRadius.only(
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
                  margin: const EdgeInsets.only(left: 5, right: 5),
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
                        child: const Text(
                          "주문현황",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: StreamBuilder(
                    stream: ordercollection
                        .where('userUid', isEqualTo: _userID!.uid)
                        .where('area_name', isEqualTo: widget.areaName)
                        .where('storeName', isEqualTo: widget.storeName)
                        .where('name', isEqualTo: widget.menu)
                        .where('count', isEqualTo: widget.count)
                        .where('ordertime', isEqualTo: widget.ordertime)
                        .where('status', isNotEqualTo: '완료')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> streamSnapshot) {
                      if (!streamSnapshot.hasData ||
                          streamSnapshot.data!.docs.isEmpty) {
                        return Container(); // 데이터가 없는 경우 처리
                      }
                      if (streamSnapshot.hasError) {
                        debugPrint('에러');
                        Container();
                      }
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot<Map<String, dynamic>>
                                documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            return Order_DeliveryListItem(
                                documentSnapshot: documentSnapshot);
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
