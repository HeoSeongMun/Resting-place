import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/cart.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/orderedlist.dart';
import 'package:flutter_app/rev_show.dart';
import 'package:flutter_app/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Menu extends StatelessWidget {
  String storeName = '';
  String areaName = '';
  Menu(this.areaName, this.storeName, {super.key});
  CollectionReference product =
      FirebaseFirestore.instance.collection('shoppingBasket');
  CollectionReference product1 = FirebaseFirestore.instance.collection('area');
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color(0xFFAAC4FF),
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                color: const Color(0xFFAAC4FF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        'assets/images/menu1.jpg',
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 140,
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                              storeName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    areaName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 70),
                                  width: 70,
                                  height: 25,
                                  child: ElevatedButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        side: const BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReviewListPage(storeName)),
                                        );
                                      },
                                      child: const Text(
                                        "리뷰보기",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
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
              Container(
                height: 1.8,
                color: Colors.black,
              ),
              Container(
                height: 580,
                color: Colors.white,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('menu')
                      .where("storeName", isEqualTo: storeName)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            return Card(
                              child: Column(
                                children: [
                                  Image.network(
                                    documentSnapshot['imageUrl'],
                                  ),
                                  ListTile(
                                    title: Text(documentSnapshot['name']),
                                    subtitle: Text(documentSnapshot['price']),
                                    onTap: () async {
                                      await product.add({
                                        'storeName': storeName,
                                        'name': documentSnapshot['name'],
                                        'price': documentSnapshot['price'],
                                        'location': areaName,
                                        'userUid': user!.uid,
                                        'storeUid':
                                            documentSnapshot['storeUid'],
                                      });
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Cart(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
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
            selectedItemColor: Colors.grey,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
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
    );
  }
}
