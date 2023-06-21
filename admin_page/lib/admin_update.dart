import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'admin_approve.dart';
import 'admin_delete.dart';
import 'admin_request_list.dart';

class AdminUpdate extends StatefulWidget {
  const AdminUpdate({super.key});

  @override
  _AdminUpdate createState() => _AdminUpdate();
}

class _AdminUpdate extends State<AdminUpdate> {
  String searchText = '';
  String selectedName = '';
  String changedName = '';
  String docID = '';
  final TextEditingController controller = TextEditingController();
  final TextEditingController selectedController = TextEditingController();
  CollectionReference area =
      FirebaseFirestore.instance.collection('admin_area');

  @override
  void initState() {
    super.initState();
  }

  _AdminUpdate() {
    controller.addListener(() {
      setState(() {
        searchText = controller.text;
      });
    });

    selectedController.addListener(() {
      setState(() {
        changedName = selectedController.text;
      });
    });
  }

  void selectArea(String name, String documentID) {
    setState(() {
      selectedName = name;
      docID = documentID;
      selectedController.text = name;
    });
  }

  //1. 업데이트를 했을 때 admin_area 콜렉션 이외에 다른 콜렉션(ex. store 콜렉션)에서도 데이터 변환이 이루어져야함.
  //2. 이미지 파일 추가(동적 맵 객체 구조 참고)
  void updateArea(String documentID, Map<String, dynamic> dataUpdate) async {
    await area.doc(documentID).update(dataUpdate);
  }

  //1. 위 업데이트와 동일
  void addArea() async {
    Map<String, dynamic> data = <String, dynamic>{
      'area_name': changedName
      //'이미지-필드명' : [이미지파일 경로]
    };

    await area.add(data);
  }

  //1. 위 업데이트와 동일
  void deleteArea(String documentID) async {
    await area.doc(documentID).delete();
    setState(() {
      docID = '';
      selectedName = '';
    });
  }

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
                                builder: (context) => const AdminDelete()),
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
                                builder: (context) => const AdminUpdate()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          minimumSize: const Size(160, 90),
                        ),
                        child: const Text(
                          '휴게소 목록\n수정',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
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
                        child: const Text('휴게소 추가/수정/삭제',
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
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 250,
                        height: MediaQuery.of(context).size.height - 200,
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 250,
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 50,
                                    color: Colors.grey,
                                    alignment: Alignment.center,
                                    child: const Text('휴게소 검색',
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
                                      onChanged: (val) {
                                        setState(() {
                                          searchText = val;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: '휴게소이름 입력...',
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.cancel_outlined,
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
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 250,
                              height: MediaQuery.of(context).size.height - 280,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 40,
                                          color: Colors.white,
                                          child: const Text(
                                            '검색 결과',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 5,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                325,
                                            child: StreamBuilder(
                                                stream: area.snapshots(),
                                                builder:
                                                    (context, streamSnapshot) {
                                                  if (streamSnapshot.hasData) {
                                                    return ListView.builder(
                                                      itemCount: streamSnapshot
                                                          .data!.docs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var data =
                                                            streamSnapshot.data!
                                                                    .docs[index]
                                                                    .data()
                                                                as Map<String,
                                                                    dynamic>;
                                                        final DocumentSnapshot
                                                            documentSnapshot =
                                                            streamSnapshot.data!
                                                                .docs[index];
                                                        String docID =
                                                            documentSnapshot.id;
                                                        if (data['area_name']
                                                            .toString()
                                                            .contains(
                                                                searchText)) {
                                                          return Card(
                                                            child: ListTile(
                                                              title: Text(data[
                                                                  'area_name']),
                                                              trailing:
                                                                  const Icon(Icons
                                                                      .arrow_circle_right),
                                                              onTap: () {
                                                                selectArea(
                                                                    data[
                                                                        'area_name'],
                                                                    docID);
                                                              },
                                                            ),
                                                          );
                                                        } else if (searchText
                                                            .isEmpty) {
                                                          return Card(
                                                            child: ListTile(
                                                              title: Text(data[
                                                                  'area_name']),
                                                              trailing:
                                                                  const Icon(Icons
                                                                      .arrow_circle_right),
                                                              onTap: () {
                                                                selectArea(
                                                                    data[
                                                                        'area_name'],
                                                                    docID);
                                                              },
                                                            ),
                                                          );
                                                        }
                                                        return Container();
                                                      },
                                                    );
                                                  }
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 5,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 555,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: 200,
                                                height: 50,
                                                child: const Text(
                                                  '휴게소 이름',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  alignment: Alignment.center,
                                                  width: 350,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                  child: TextField(
                                                    controller:
                                                        selectedController,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelStyle: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    onChanged: (val) {
                                                      setState(() {
                                                        changedName = val;
                                                      });
                                                    },
                                                  )

                                                  /*Text(
                                            selectedName,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),*/
                                                  )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 400,
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: 200,
                                                height: 50,
                                                child: const Text(
                                                  '사진',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                width: 350,
                                                height: 350,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Text(docID),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey,
                                                minimumSize:
                                                    const Size(100, 40),
                                              ),
                                              child: const Text(
                                                '찾아보기',
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: ((context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              '휴게소 추가'),
                                                          content: Text(
                                                              '$changedName휴게소를 추가하시겠습니까?'),
                                                          actions: [
                                                            Container(
                                                              child:
                                                                  ElevatedButton(
                                                                child:
                                                                    const Text(
                                                                        '확인'),
                                                                onPressed: () {
                                                                  addArea();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              child:
                                                                  ElevatedButton(
                                                                child:
                                                                    const Text(
                                                                        '취소'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      }));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.grey,
                                                  minimumSize:
                                                      const Size(100, 40),
                                                ),
                                                child: const Text(
                                                  '추가',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: ((context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              '[$selectedName -> $changedName ] 수정'),
                                                          content: const Text(
                                                              '해당 휴게소 정보를 수정하시겠습니까?'),
                                                          actions: [
                                                            Container(
                                                              child:
                                                                  ElevatedButton(
                                                                child:
                                                                    const Text(
                                                                        '확인'),
                                                                onPressed: () {
                                                                  updateArea(
                                                                      docID, {
                                                                    'area_name':
                                                                        changedName
                                                                  });
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              child:
                                                                  ElevatedButton(
                                                                child:
                                                                    const Text(
                                                                        '취소'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      }));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.grey,
                                                  minimumSize:
                                                      const Size(100, 40),
                                                ),
                                                child: const Text(
                                                  '수정',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: ((context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              '[$selectedName] 삭제'),
                                                          content: const Text(
                                                              '해당 휴게소를 삭제하시겠습니까?'),
                                                          actions: [
                                                            Container(
                                                              child:
                                                                  ElevatedButton(
                                                                child:
                                                                    const Text(
                                                                        '확인'),
                                                                onPressed: () {
                                                                  deleteArea(
                                                                      docID);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  selectedController
                                                                      .text = '';
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              child:
                                                                  ElevatedButton(
                                                                child:
                                                                    const Text(
                                                                        '취소'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      }));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.grey,
                                                  minimumSize:
                                                      const Size(100, 40),
                                                ),
                                                child: const Text(
                                                  '삭제',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ))
                  ],
                )),
          ],
        ));
  }
}
