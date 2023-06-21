import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'admin_approve.dart';
import 'admin_request_list.dart';
import 'admin_update.dart';

class AdminDelete extends StatefulWidget {
  const AdminDelete({super.key});

  @override
  _AdminDelete createState() => _AdminDelete();
}

class _AdminDelete extends State<AdminDelete> {
  final controller = TextEditingController();

  CollectionReference store =
      FirebaseFirestore.instance.collection('admin_store');
  String searchText = '';
  //late 한번 뺴보자
  void deleteStore(String documentID) async {
    await store.doc(documentID).delete();
  }

  _adminDeleteState() {
    controller.addListener(() {
      setState(() {
        searchText = controller.text;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  /* void controlSearching(str) {
    print(str);
    Future<QuerySnapshot> allUsers = store.where('store_name', isGreaterThanOrEqualTo: str).get();
    setState(() {
      futureSearchResults = allUsers;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            '휴게소에서 뭐먹지 Admin',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          centerTitle: true,
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 200,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminRequestList()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(160, 90),
                        ),
                        child: const Text(
                          '휴게소 식당\n등록 요청',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminDelete()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          minimumSize: const Size(160, 90),
                        ),
                        child: const Text(
                          '휴게소 식당\n삭제',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminUpdate()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(160, 90),
                        ),
                        child: const Text(
                          '휴게소 목록\n수정',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ])),
            Container(
                width: MediaQuery.of(context).size.width - 200,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width - 250,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        color: Colors.white,
                        child: const Text('휴게소 식당 검색 및 삭제',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ))),
                    Container(
                      width: MediaQuery.of(context).size.width - 250,
                      height: 5,
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      color: Colors.black,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 250,
                        height: MediaQuery.of(context).size.height - 150,
                        color: Colors.purple,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 250,
                              height: 250,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 600,
                                    height: 90,
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: 100,
                                          height: 50,
                                          color: Colors.white,
                                          child: const Text('식당 검색',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 300,
                                          height: 50,
                                          child: TextField(
                                            controller: controller,
                                            decoration: const InputDecoration(
                                              labelText: '식당이름 입력...',
                                            ),
                                            onChanged: (val) {
                                              setState(() {
                                                searchText = val;
                                              });
                                            },
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.clear,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              controller.clear();
                                              searchText = '';
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 250,
                              height: 5,
                              color: Colors.grey,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 250,
                                height:
                                    MediaQuery.of(context).size.height - 405,
                                color: Colors.white,
                                child: StreamBuilder(
                                    stream: store.snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot>
                                            streamSnapshot) {
                                      if (streamSnapshot.hasData) {
                                        return ListView.builder(
                                            itemCount: streamSnapshot
                                                .data!.docs.length,
                                            itemBuilder: (context, index) {
                                              var data = streamSnapshot
                                                      .data!.docs[index]
                                                      .data()
                                                  as Map<String, dynamic>;
                                              final DocumentSnapshot
                                                  documentSnapshot =
                                                  streamSnapshot
                                                      .data!.docs[index];
                                              String docID =
                                                  documentSnapshot.id;
                                              if (data['store_name']
                                                  .toString()
                                                  .contains(searchText)) {
                                                return Card(
                                                  child: ListTile(
                                                    title: Text(
                                                        data['store_name']),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                true,
                                                            builder:
                                                                ((context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    '${'[' + data['store_name']}] 삭제'),
                                                                content: const Text(
                                                                    '해당 식당을 삭제하시겠습니까?'),
                                                                actions: [
                                                                  Container(
                                                                    child:
                                                                        ElevatedButton(
                                                                      child: const Text(
                                                                          '확인'),
                                                                      onPressed:
                                                                          () {
                                                                        deleteStore(
                                                                            docID);
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        ElevatedButton(
                                                                      child: const Text(
                                                                          '취소'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }));
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }
                                              return null;
                                            });
                                      }
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }))
                          ],
                        )),
                  ],
                )),
          ],
        ));
  }
}
