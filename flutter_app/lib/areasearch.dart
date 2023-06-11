import 'package:flutter/material.dart';
import 'package:flutter_app/cart.dart';
import 'package:flutter_app/home.dart';
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

  _AreaSearchState() {
    filter.addListener(() {
      setState(() {
        searchText = filter.text;
      });
    });
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
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
                        onChanged: (val) {
                          setState(() {
                            searchText = val;
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
                              : Container(),
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
                    focusNode.hasFocus
                        ? Container(
                            child: TextButton(
                              child: Text('취소'),
                              onPressed: () {
                                setState(() {
                                  filter.clear();
                                  searchText = "";
                                  focusNode.unfocus();
                                });
                              },
                            ),
                          )
                        : Expanded(
                            flex: 0,
                            child: Container(),
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
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = streamSnapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                              if (searchText.isEmpty) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      data['location'],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Restaurant(data['location']),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              if (data['location']
                                  .toString()
                                  .contains(searchText)) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      data['location'],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Restaurant(data['location']),
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
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 60,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: const Icon(Icons.home),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    }),
                IconButton(
                  icon: const Icon(
                    Icons.man,
                  ),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserPage()),
                    );
                  },
                ),
                IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AreaSearch()),
                      );
                    }),
              ],
            ),
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
    );
  }
}
