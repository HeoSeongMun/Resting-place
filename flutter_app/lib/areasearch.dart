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

    Set<String> uniqueSet = Set<String>();

    for (var doc in snapshot.docs) {
      String data = doc['location'];
      uniqueSet.add(data);
    }

    setState(() {
      uniqueData = uniqueSet.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      width: 335,
                      margin: EdgeInsets.only(left: 10),
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
                          fillColor: Color(0xFFAAC4FF),
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
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
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  child: const Text(
                    "검색된 휴게소",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 520,
                  width: 290,
                  color: const Color(0xFFD2DAFF),
                  child: StreamBuilder(
                    stream: product.snapshots(),
                    builder: (context, streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                            itemCount: uniqueData.length,
                            itemBuilder: (context, index) {
                              String data = uniqueData[index];
                              if (searchText.isEmpty) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      data,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Restaurant(data),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              if (data.toString().contains(searchText)) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      data,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Restaurant(data),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return Container();
                            });
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              currentIndex: 0,
              elevation: 20,
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(),
                ),
              );
            },
            child: const Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
