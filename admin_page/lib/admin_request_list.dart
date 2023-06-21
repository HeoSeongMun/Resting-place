import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'admin_delete.dart';
import 'admin_approve.dart';
import 'admin_update.dart';

class AdminRequestList extends StatelessWidget {
  CollectionReference storerequest =
      FirebaseFirestore.instance.collection('admin_request');

  AdminRequestList({super.key});
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        minimumSize: const Size(160, 90),
                      ),
                      child: const Text(
                        '휴게소 식당\n등록 요청',
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
                            builder: (context) => const AdminDelete(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(160, 90),
                      ),
                      child: const Text(
                        '휴게소 식당\n삭제',
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
                            builder: (context) => const AdminUpdate(),
                          ),
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
                    child: const Text('휴게소 식당 등록 요청 목록',
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
                    height: MediaQuery.of(context).size.height - 200,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: StreamBuilder(
                      stream: storerequest.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              String docID = documentSnapshot.id;
                              return Card(
                                child: ListTile(
                                  title: Text(
                                    documentSnapshot['store_name'],
                                  ),
                                  subtitle: Text(
                                    'UserID : ' +
                                        documentSnapshot['owner_nickname'],
                                  ),
                                  onTap: () {
                                    /*Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => AdminApprove(documentSnapshot['owner_id'])
                                      ),
                                    );*/
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdminApprove(
                                          docID: docID,
                                          restAreaName:
                                              documentSnapshot['restarea_name'],
                                          bizNum:
                                              documentSnapshot['biz_number'],
                                          storeName:
                                              documentSnapshot['store_name'],
                                          ownerID: documentSnapshot[
                                              'owner_nickname'],
                                          ownerName:
                                              documentSnapshot['owner_name'],
                                          ownerPW: documentSnapshot[
                                              'owner_password'],
                                          ownerPhone:
                                              documentSnapshot['phone_number'],
                                          direction:
                                              documentSnapshot['direction'],
                                          ownerEmail:
                                              documentSnapshot['owner_email'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    )
                    /*child: ListView.separated(
                    itemCount: 3,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      List<String> _storeName = ['한국 한식당', '일본 일식당', '중국 중식당'];
                      List<String> _storeId = ['KRRstg', 'JPRstg', 'CNRstg'];

                      return ListTile(
                        title: Text(_storeName[index]),
                        subtitle: Text('ID : ' + _storeId[index]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdminApprove()),
                          );
                        }
                      );
                    }
                  )*/
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
