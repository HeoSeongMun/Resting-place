import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'admin_delete.dart';
import 'admin_request_list.dart';
import 'admin_update.dart';

class AdminApprove extends StatelessWidget {
  final _authentication = FirebaseAuth.instance;

  String docID;
  AdminApprove({
    super.key,
    required this.docID,
    required this.restAreaName,
    required this.storeName,
    required this.ownerID,
    required this.ownerName,
    required this.ownerPW,
    required this.ownerPhone,
    required this.bizNum,
    //추가
    required this.direction,
    required this.ownerEmail,
  });

  //Query query = FirebaseFirestore.instance.collection('admin_request').where('user_id', isEqualTo: userID);

  String restAreaName;
  String storeName;
  String ownerName;
  String ownerID;
  String ownerPW;
  String ownerPhone;
  String bizNum;
  //추가
  String direction;
  String ownerEmail;

  final CollectionReference request =
      FirebaseFirestore.instance.collection('admin_request');
  final CollectionReference store =
      FirebaseFirestore.instance.collection('admin_store');
  final CollectionReference testlogin =
      FirebaseFirestore.instance.collection('testlogin');
  final CollectionReference area =
      FirebaseFirestore.instance.collection('area');
  /* Future<void> getData() async {
    DocumentSnapshot docSnapshot;
    try {
      docSnapshot = await _mainCollection.doc(docID).get();
      restAreaName = docSnapshot.get('area_name').toString();
    } catch(e) {
      print(e);
    }
  }
  */
  void denyRequest(String documentID) async {
    await request.doc(documentID).delete();
  }

  void approveRequest() async {
    Map<String, dynamic> data = <String, dynamic>{
      'restarea_name': restAreaName,
      'store_name': storeName,
      'owner_name': ownerName,
      'owner_nickname': ownerID,
      'owner_password': ownerPW,
      'phone_number': ownerPhone,
      'biz_number': bizNum,
      'owner_email': ownerEmail,
      'direction': direction,
    };

    await store.add(data);
  }

  void storeInformation() async {
    Map<String, dynamic> data = <String, dynamic>{
      'restAreaName': restAreaName,
      'storeName': storeName,
      'storeId': ownerID,
      'email': ownerEmail,
      'direction': direction,
    };

    await testlogin.add(data);
  }

  void areaname() async {
    Map<String, dynamic> data = <String, dynamic>{
      'location': restAreaName,
    };

    await testlogin.add(data);
  }

/*ElevatedButton(
                        onPressed: () async {
                          await _authentication.createUserWithEmailAndPassword(
                            email: ownerEmail,
                            password: ownerPW,
                          );
                        },
                        child: const Text('회원가입'),
                      ),*/
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
                              builder: (context) => AdminDelete()),
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
                              builder: (context) => AdminUpdate()),
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
                    child: const Text('등록 요청 승인',
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
                  height: MediaQuery.of(context).size.height - 170,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width - 250,
                          height: 40,
                          color: Colors.white,
                          child: Row(children: [
                            Container(
                                width: 100,
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: const Text('휴게소 이름',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            Container(
                              width: 400,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                restAreaName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ])),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          width: MediaQuery.of(context).size.width - 250,
                          height: 40,
                          color: Colors.white,
                          child: Row(children: [
                            Container(
                                width: 100,
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: const Text('휴게소 방향',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            Container(
                              width: 400,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                direction,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ])),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          width: MediaQuery.of(context).size.width - 250,
                          height: 40,
                          color: Colors.white,
                          child: Row(children: [
                            Container(
                                width: 100,
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: const Text('식당 이름',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            Container(
                              width: 400,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                storeName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ])),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          width: MediaQuery.of(context).size.width - 250,
                          height: 40,
                          color: Colors.white,
                          child: Row(children: [
                            Container(
                                width: 100,
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: const Text('요청자 성명',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            Container(
                              width: 400,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                ownerName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ])),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          width: MediaQuery.of(context).size.width - 250,
                          height: 40,
                          color: Colors.white,
                          child: Row(children: [
                            Container(
                                width: 100,
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: const Text('요청자 ID',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            Container(
                              width: 400,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                ownerID,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ])),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          width: MediaQuery.of(context).size.width - 250,
                          height: 40,
                          color: Colors.white,
                          child: Row(children: [
                            Container(
                                width: 100,
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: const Text('요청자 이메일',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            Container(
                              width: 400,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                ownerEmail,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ])),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          width: MediaQuery.of(context).size.width - 250,
                          height: 40,
                          color: Colors.white,
                          child: Row(children: [
                            Container(
                                width: 100,
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: const Text('비밀번호',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            Container(
                              width: 400,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                ownerPW,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ])),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          width: MediaQuery.of(context).size.width - 250,
                          height: 40,
                          color: Colors.white,
                          child: Row(children: [
                            Container(
                                width: 100,
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: const Text('휴대폰 번호',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            Container(
                              width: 400,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                ownerPhone,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ])),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          width: MediaQuery.of(context).size.width - 250,
                          height: 40,
                          color: Colors.white,
                          child: Row(children: [
                            Container(
                              width: 100,
                              color: Colors.white,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                '사업자 번호',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 400,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                bizNum,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ])),
                      Container(
                        width: 400,
                        height: 60,
                        margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        color: Colors.white,
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: ((context) {
                                      return AlertDialog(
                                        title: const Text('승인'),
                                        content: const Text('승인하시겠습니까?'),
                                        actions: [
                                          ElevatedButton(
                                            child: const Text('확인'),
                                            onPressed: () async {
                                              approveRequest();
                                              storeInformation();
                                              areaname();
                                              denyRequest(docID);
                                              await _authentication
                                                  .createUserWithEmailAndPassword(
                                                email: ownerEmail,
                                                password: ownerPW,
                                              );
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text('승인 완료'),
                                                      content: const Text(
                                                          '승인 완료됬습니다.'),
                                                      actions: [
                                                        ElevatedButton(
                                                          child:
                                                              const Text('확인'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                                    MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AdminRequestList(),
                                                            ));
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }));
                                            },
                                          ),
                                          ElevatedButton(
                                            child: const Text('취소'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    }));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                minimumSize: const Size(160, 60),
                              ),
                              child: const Text(
                                '승인',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 80),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: ((context) {
                                      return AlertDialog(
                                        title: const Text('거절'),
                                        content: const Text('거절하시겠습니까?'),
                                        actions: [
                                          ElevatedButton(
                                            child: const Text('확인'),
                                            onPressed: () {
                                              denyRequest(docID);
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text('거절 완료'),
                                                      content: const Text(
                                                          '거절 완료됬습니다.'),
                                                      actions: [
                                                        ElevatedButton(
                                                          child:
                                                              const Text('확인'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                                    MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AdminRequestList(),
                                                            ));
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }));
                                            },
                                          ),
                                          ElevatedButton(
                                            child: const Text('취소'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    }));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                minimumSize: const Size(160, 60),
                              ),
                              child: const Text(
                                '거절',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
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
    );
  }
}
