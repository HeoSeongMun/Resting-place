import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/mainpage.dart';

class Sales extends StatelessWidget {
  const Sales({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFAAC4FF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 290,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('items')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                final docs = snapshot.data!.docs;
                                return ListView.builder(
                                  itemCount: docs.length,
                                  itemBuilder: (context, index) {
                                    return TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black),
                                      child: Text(
                                        docs[index]['name'],
                                        style: const TextStyle(fontSize: 40),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainPage(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('items')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            final docs = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  docs[index]['subname'],
                                  textAlign: TextAlign.center,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD2DAFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 154,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('매출관리'),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 60,
                            horizontal: 10,
                          ),
                          child: Column(
                            children: const [Text('일일매출')],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFD2DAFF),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 60,
                            horizontal: 10,
                          ),
                          child: Column(
                            children: const [Text('월간매출')],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFD2DAFF),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 60,
                            horizontal: 10,
                          ),
                          child: Column(
                            children: const [Text('연간매출')],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFD2DAFF),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 61,
                            horizontal: 10,
                          ),
                          child: Column(
                            children: const [Text('날짜매출')],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xFFD2DAFF),
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 55,
                            ),
                            child: Text('2022-12-25 ~ 2023-01-15'),
                          ),
                        ),
                      ),
                      Container(
                        height: 2.0,
                        width: 240.0,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: const SizedBox(
                              width: 145,
                              child: Text(
                                '매출 구분',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: const SizedBox(
                              width: 100,
                              child: Text(
                                '매출',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 2.0,
                        width: 240.0,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: const SizedBox(
                              width: 145,
                              child: Text(
                                '카드 매출',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: const SizedBox(
                              width: 100,
                              child: Text(
                                'number',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 2.0,
                        width: 240.0,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: const SizedBox(
                              width: 145,
                              child: Text(
                                '현금 매출',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 5,
                            ),
                            child: const SizedBox(
                              width: 100,
                              child: Text(
                                'number',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
