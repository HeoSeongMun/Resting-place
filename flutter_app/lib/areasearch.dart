import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/cart.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/orderedlist.dart';
import 'package:flutter_app/restaurant.dart';
import 'package:flutter_app/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AreaSearch extends StatefulWidget {
  const AreaSearch({super.key});

  @override
  State<AreaSearch> createState() => _AreaSearchState();
}

class _AreaSearchState extends State<AreaSearch> {
  final TextEditingController filter = TextEditingController();
  CollectionReference areacollection =
      FirebaseFirestore.instance.collection('area');
  CollectionReference cartcollection =
      FirebaseFirestore.instance.collection('shoppingBasket');
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');

  final user = FirebaseAuth.instance.currentUser;
  FocusNode focusNode = FocusNode();
  String searchText = "";

  _AreaSearchState() {
    filter.addListener(() {
      setState(() {
        searchText = filter.text;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'jalnan'),
        home: Scaffold(
          backgroundColor: const Color(0xFFEEF1FF),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                  width: MediaQuery.of(context).size.width,
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            iconSize: 35,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            child: Flexible(
                              child: TextField(
                                focusNode: focusNode,
                                controller: filter,
                                onChanged: (text) {
                                  setState(() {
                                    searchText = text;
                                  });
                                },
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                  ),
                                  suffixIcon: focusNode.hasFocus
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              filter.clear();
                                              searchText = "";
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            size: 20,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              filter.clear();
                                              searchText = "";
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            size: 20,
                                          ),
                                        ),
                                  hintText: '검색',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[400]),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFC5DFF8)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFC5DFF8)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFC5DFF8)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  height: MediaQuery.of(context).size.height - 220,
                  decoration: BoxDecoration(
                      color: const Color(0xFFC5DFF8),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
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
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 20),
                              child: const Text(
                                "검색된 휴게소",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        height: MediaQuery.of(context).size.height - 280,
                        child: StreamBuilder(
                          stream: areacollection.snapshots(),
                          builder: (context, streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              return ListView.builder(
                                itemCount: streamSnapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot documentSnapshot =
                                      streamSnapshot.data!.docs[index];
                                  if (searchText.isEmpty) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 10),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFffffff),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                            bottomLeft: Radius.circular(25.0),
                                            bottomRight: Radius.circular(25.0),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.7),
                                              blurRadius: 5,
                                              spreadRadius: 0,
                                              offset: const Offset(0, 7),
                                            ),
                                          ]),
                                      child: ListTile(
                                        leading: documentSnapshot['imageUrl']
                                                .toString()
                                                .isEmpty
                                            ? Image.asset(
                                                'assets/images/cross.png')
                                            : Image.network(
                                                documentSnapshot['imageUrl'],
                                                width: 100,
                                                fit: BoxFit.fill,
                                              ),
                                        title: Text(
                                          documentSnapshot['location'],
                                        ),
                                        subtitle: Text(
                                          documentSnapshot['direction'],
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        onTap: () async {
                                          final result =
                                              await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Restaurant(
                                                  documentSnapshot['location'],
                                                  documentSnapshot['imageUrl']
                                                      .toString()),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  if (documentSnapshot['location']
                                      .toString()
                                      .contains(searchText)) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 10),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFffffff),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                            bottomLeft: Radius.circular(25.0),
                                            bottomRight: Radius.circular(25.0),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.7),
                                              blurRadius: 5,
                                              spreadRadius: 0,
                                              offset: const Offset(0, 7),
                                            ),
                                          ]),
                                      child: ListTile(
                                        leading: Image.network(
                                          documentSnapshot['imageUrl'],
                                          width: 100,
                                          fit: BoxFit.fill,
                                        ),
                                        title: Text(
                                          documentSnapshot['location'],
                                        ),
                                        subtitle: Text(
                                          documentSnapshot['direction'],
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        onTap: () async {
                                          final result =
                                              await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Restaurant(
                                                  documentSnapshot['location'],
                                                  documentSnapshot['imageUrl']
                                                      .toString()),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return Container();
                                },
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
          bottomNavigationBar: SizedBox(
            height: 70,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                elevation: 20,
                currentIndex: 0,
                onTap: (int index) async {
                  switch (index) {
                    case 0: //검색
                      setState(() {});
                      break;
                    case 1: //장바구니
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Cart()),
                      );

                      break;
                    case 2: //홈
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (route) => false,
                      );
                      break;
                    case 3: //주문내역
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderedList()),
                      );
                      break;
                    case 4: //마이휴잇
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserPage()),
                      );
                      break;
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                          ),
                          child: Icon(Icons.search),
                        ),
                        Positioned(
                          top: 0,
                          right: 3,
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child: Text(
                              '',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    label: '검색',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                          ),
                          child: Icon(Icons.shopping_cart_outlined),
                        ),
                        Positioned(
                          top: 0,
                          right: 3,
                          child: StreamBuilder(
                            stream: cartcollection
                                .where('userUid', isEqualTo: user!.uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot streamSnapshot) {
                              if (!streamSnapshot.hasData ||
                                  streamSnapshot.data!.docs.isEmpty) {
                                return Container(); // 데이터가 없는 경우 처리
                              }
                              if (streamSnapshot.hasError) {
                                debugPrint('에러');
                                Container();
                              }
                              if (streamSnapshot.hasData) {
                                int count = streamSnapshot.data!.docs.length;
                                return Container(
                                    alignment: Alignment.center,
                                    width: 15,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(count.toString()));
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        )
                      ],
                    ),
                    label: '장바구니',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                          ),
                          child: Icon(Icons.home_outlined),
                        ),
                        Positioned(
                          top: 0,
                          right: 3,
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child: Text(
                              '',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    label: '홈',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                          ),
                          child: Icon(Icons.receipt_long_outlined),
                        ),
                        Positioned(
                          top: 0,
                          right: 3,
                          child: StreamBuilder(
                            stream: ordercollection
                                .where('userUid', isEqualTo: user!.uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot streamSnapshot) {
                              if (!streamSnapshot.hasData ||
                                  streamSnapshot.data!.docs.isEmpty) {
                                return Container(); // 데이터가 없는 경우 처리
                              }
                              if (streamSnapshot.hasError) {
                                debugPrint('에러');
                                Container();
                              }
                              if (streamSnapshot.hasData) {
                                int count = streamSnapshot.data!.docs.length;
                                return Container(
                                    alignment: Alignment.center,
                                    width: 15,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(count.toString()));
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        )
                      ],
                    ),
                    label: '주문내역',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                          ),
                          child: Icon(Icons.face),
                        ),
                        Positioned(
                          top: 0,
                          right: 3,
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child: Text(
                              '',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    label: '마이휴잇',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
