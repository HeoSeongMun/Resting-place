import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/cart.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/menu.dart';
import 'package:flutter_app/orderedlist.dart';
import 'package:flutter_app/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant extends StatefulWidget {
  Restaurant(this.areaName, this.imageUrl, {super.key});

  String areaName = '';
  String imageUrl = '';

  @override
  State<Restaurant> createState() => _Restaurant();
}

class _Restaurant extends State<Restaurant> {
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  CollectionReference cartcollection =
      FirebaseFirestore.instance.collection('shoppingBasket');
  final user = FirebaseAuth.instance.currentUser;
  int cartcount = 0;
  int ordercount = 0;

  void initState() {
    super.initState();
    CartCount();
    OrderCount();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'jalnan'),
      home: Scaffold(
        backgroundColor: Color(0xFFEEF1FF),
        body: Column(
          children: [
            Container(
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
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 25,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          onPressed: () {
                            Navigator.pop(context, cartcount);
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 40, left: 40, bottom: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.imageUrl,
                        height: 150,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.areaName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 385,
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
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('testlogin')
                      .where("restAreaName", isEqualTo: widget.areaName)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (!streamSnapshot.hasData || streamSnapshot.hasError) {
                      return Container();
                    }
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          if (documentSnapshot['storeimageUrl'] == '' ||
                              documentSnapshot['storeName'] == '' ||
                              documentSnapshot['signaturemenu'] == '') {
                            return Container();
                          }
                          return Container(
                            margin:
                                EdgeInsets.only(left: 5, right: 5, bottom: 10),
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
                                    color: Colors.grey.withOpacity(0.7),
                                    blurRadius: 5,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 7),
                                  ),
                                ]),
                            child: ListTile(
                              leading: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Image.network(
                                  documentSnapshot['storeimageUrl'],
                                  height: 120,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              title: Text(documentSnapshot['storeName']),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  '대표메뉴: ' + documentSnapshot['signaturemenu'],
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              onTap: () async {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Menu(
                                        widget.areaName,
                                        documentSnapshot['storeName'],
                                        documentSnapshot['storeimageUrl']
                                            .toString()),
                                  ),
                                );
                                if (result != null) {
                                  setState(() {
                                    CartCount();
                                  });
                                }
                              },
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
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
              onTap: (int index) async {
                switch (index) {
                  case 0: //검색
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AreaSearch()),
                    );
                    if (result != null) {
                      setState(() {
                        CartCount();
                      });
                    }
                    break;
                  case 1: //장바구니
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cart()),
                    );
                    if (result != null) {
                      setState(() {
                        CartCount();
                      });
                    }
                    break;
                  case 2: //홈
                    final result = await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (route) => false,
                    );
                    if (result != null) {
                      setState(() {
                        CartCount();
                      });
                    }
                    break;
                  case 3: //주문내역
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderedList()),
                    );
                    if (result != null) {
                      setState(() {
                        CartCount();
                      });
                    }
                    break;
                  case 4: //마이휴잇
                    final result = await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => UserPage()),
                      (route) => false,
                    );
                    if (result != null) {
                      setState(() {
                        CartCount();
                      });
                    }
                    break;
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
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
                        child: Container(
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
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 10,
                        ),
                        child: Icon(Icons.shopping_cart_outlined),
                      ),
                      if (cartcount > 0)
                        Positioned(
                          top: 0,
                          right: 3,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              cartcount.toString(),
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                    ],
                  ),
                  label: '장바구니',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
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
                        child: Container(
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
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 10,
                        ),
                        child: Icon(Icons.receipt_long_outlined),
                      ),
                      if (ordercount > 0)
                        Positioned(
                          top: 0,
                          right: 3,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              ordercount.toString(),
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  label: '주문내역',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
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
                        child: Container(
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
    );
  }

  Future<void> CartCount() async {
    QuerySnapshot snapshot =
        await cartcollection.where('userUid', isEqualTo: user!.uid).get();

    int count = snapshot.docs.length;

    setState(() {
      cartcount = count;
    });
  }

  Future<void> OrderCount() async {
    QuerySnapshot snapshot = await ordercollection
        .where('userUid', isEqualTo: user!.uid)
        .where('status', isNotEqualTo: '완료')
        .get();

    int count = snapshot.docs.length;

    setState(() {
      ordercount = count;
    });
  }
}
