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
  CollectionReference product = FirebaseFirestore.instance.collection('area');
  FocusNode focusNode = FocusNode();
  String searchText = "";
  List<String> uniqueData = [];
  List<String> uniqueData1 = [];

  _AreaSearchState() {
    filter.addListener(() {
      setState(() {
        searchText = filter.text;
      });
    });
  }

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    QuerySnapshot snapshot = await product.get();

    List<String> uniqueSet = [];
    List<String> uniqueSet1 = [];
    for (var doc in snapshot.docs) {
      String data = doc['location'];
      String data1 = doc['imageUrl'];
      uniqueSet.add(data);
      uniqueSet1.add(data1);
    }

    setState(() {
      uniqueData = uniqueSet.toList();
      uniqueData1 = uniqueSet1.toList();
    });
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
          backgroundColor: Color(0xFFEEF1FF),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFD2DAFF),
                      borderRadius: BorderRadius.only(
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
                      SizedBox(
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
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  prefixIcon: Icon(
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
                                          icon: Icon(
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
                                          icon: Icon(
                                            Icons.cancel,
                                            size: 20,
                                          ),
                                        ),
                                  hintText: '검색',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[400]),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFC5DFF8)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFC5DFF8)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  border: OutlineInputBorder(
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
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  height: MediaQuery.of(context).size.height - 220,
                  decoration: BoxDecoration(
                      color: Color(0xFFC5DFF8),
                      borderRadius: BorderRadius.only(
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
                              margin: EdgeInsets.only(left: 10, top: 20),
                              child: Text(
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
                          stream: product.snapshots(),
                          builder: (context, streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              return ListView.builder(
                                itemCount: uniqueData.length,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot documentSnapshot =
                                      streamSnapshot.data!.docs[index];
                                  String data = uniqueData[index]; // location
                                  String data1 = uniqueData[index]; // imageUrl
                                  if (searchText.isEmpty) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: 5, right: 5, bottom: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFffffff),
                                          borderRadius: BorderRadius.only(
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
                                          data,
                                        ),
                                        subtitle: Text(
                                          documentSnapshot['direction'],
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Restaurant(
                                                  data,
                                                  documentSnapshot['imageUrl']
                                                      .toString()),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  if (data.toString().contains(searchText)) {
                                    return Card(
                                      child: ListTile(
                                        leading: Image.network(
                                          documentSnapshot['imageUrl'],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        ),
                                        title: Text(
                                          data,
                                        ),
                                        subtitle: Text(
                                          documentSnapshot['direction'],
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Restaurant(
                                                  data,
                                                  documentSnapshot['imageUrl']
                                                      .toString()),
                                            ),
                                          );
                                          filter.dispose();
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
          bottomNavigationBar: Container(
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                elevation: 20,
                currentIndex: 0,
                onTap: (int index) {
                  switch (index) {
                    case 0: //검색
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AreaSearch()),
                      );
                      break;
                    case 1: //장바구니
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cart()),
                      );
                      break;
                    case 2: //홈
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                      break;
                    case 3: //주문내역
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderedList()),
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
                    icon: Icon(Icons.search),
                    label: '검색',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: '장바구니',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: '홈',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.receipt_long_outlined),
                    label: '주문내역',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.face),
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
