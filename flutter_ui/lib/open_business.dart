import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/mainpage.dart';

class OpenBusiness extends StatelessWidget {
  OpenBusiness({super.key});

  final user = FirebaseAuth.instance.currentUser;

  CollectionReference product = FirebaseFirestore.instance.collection('order');
  CollectionReference product1 =
      FirebaseFirestore.instance.collection('processing');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
                                  .collection('testlogin')
                                  .where("email", isEqualTo: user!.email)
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
                                        docs[index]['storeName'],
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
                              .collection('testlogin')
                              .where("email", isEqualTo: user!.email)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            final docs = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  docs[index]['restAreaName'] +
                                      '(' +
                                      docs[index]['direction'] +
                                      ')',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 97.5,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '주문접수',
                              style: TextStyle(fontSize: 20),
                            )
                          ]),
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
                        horizontal: 77,
                      ),
                      child: Row(children: const [
                        Text(
                          '영업 일시정지',
                          style: TextStyle(fontSize: 20),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Row(
                  children: [
                    SizedBox(
                      height: 520,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  '접수대기',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  '2',
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: const Color(0xFFD2DAFF),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  '처리중',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  '2',
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: const Color(0xFFD2DAFF),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  '완료',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  '2',
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: const Color(0xFFD2DAFF),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  '영업종료',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  '2',
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 50, right: 50),
                            height: 520,
                            width: MediaQuery.of(context).size.width - 250,
                            color: const Color(0xFFD2DAFF),
                            child: StreamBuilder(
                              stream: product
                                  .where("storeUid", isEqualTo: user!.uid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return GridView.builder(
                                    itemCount: streamSnapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot =
                                          streamSnapshot.data!.docs[index];
                                      return Card(
                                        child: ListTile(
                                          title: Text(
                                            documentSnapshot['name'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Text(
                                            documentSnapshot['price'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder: ((context) {
                                                  return AlertDialog(
                                                    title: const Text('주문 선택'),
                                                    content: const Text(
                                                        '주문을 받으시겠습니까?'),
                                                    actions: [
                                                      ElevatedButton(
                                                        child: const Text('취소'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        child: const Text('확인'),
                                                        onPressed: () async {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  ((context) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      '주문 받기 완료'),
                                                                  content:
                                                                      const Text(
                                                                          '주문 받기가 완료 되었습니다.'),
                                                                  actions: [
                                                                    ElevatedButton(
                                                                      child: const Text(
                                                                          '확인'),
                                                                      onPressed:
                                                                          () async {
                                                                        await product1
                                                                            .add({
                                                                          'storeName':
                                                                              documentSnapshot['storeName'],
                                                                          'name':
                                                                              documentSnapshot['name'],
                                                                          'price':
                                                                              documentSnapshot['price'],
                                                                          'userUid':
                                                                              user!.uid,
                                                                          'storeUid':
                                                                              documentSnapshot['storeUid'],
                                                                        });
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              }));
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                }));
                                          },
                                        ),
                                      );
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      childAspectRatio: 4 / 4,
                                    ),
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
