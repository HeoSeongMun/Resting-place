import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/cart.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/orderedlist.dart';
import 'package:flutter_app/rev_show.dart';
import 'package:flutter_app/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Menu extends StatefulWidget {
  Menu(this.areaName, this.storeName, this.storeimageUrl, this.averagegrade,
      this.gradescount,
      {super.key});
  String storeName = '';
  String areaName = '';
  String storeimageUrl = '';
  double averagegrade;
  int gradescount = 0;
  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  CollectionReference product =
      FirebaseFirestore.instance.collection('shoppingBasket');
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('order');
  final user = FirebaseAuth.instance.currentUser;
  int cartcount = 0;
  int ordercount = 0;
  Future<bool> checkItemExists(String itemName, String userUid) async {
    // 아이템이 이미 쇼핑 바스켓에 있는지 확인하는 코드
    QuerySnapshot querySnapshot = await product
        .where('name', isEqualTo: itemName)
        .where('userUid', isEqualTo: userUid)
        .where('location', isEqualTo: widget.areaName)
        .where('storeName', isEqualTo: widget.storeName)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

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
              padding: EdgeInsets.only(bottom: 5),
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
                        width: 30,
                        height: 30,
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
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 15),
                        width: 70,
                        height: 70,
                        child: Image.network(
                          widget.storeimageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 200,
                                margin: const EdgeInsets.only(top: 5),
                                child: Text(
                                  widget.storeName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 20,
                                    ),
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
                                        onPressed: () async {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewListPage(
                                                        widget.storeName)),
                                          );
                                          if (result != null) {
                                            setState(() {
                                              CartCount();
                                              OrderCount();
                                            });
                                          }
                                        },
                                        child: const Text(
                                          "리뷰보기",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    widget.areaName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 55, right: 10),
                                      width: 80,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '평점 : ' +
                                            (widget.averagegrade.isNaN
                                                ? '0'
                                                : widget.averagegrade
                                                    .toString()),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(left: 40, top: 2),
                                          child: RatingBar.builder(
                                            initialRating:
                                                widget.averagegrade.isNaN
                                                    ? 0
                                                    : widget.averagegrade,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            ignoreGestures: true,
                                            updateOnDrag: false,
                                            allowHalfRating: false,
                                            itemCount: 5,
                                            itemSize: 15,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (_) {},
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 10, top: 4),
                                          child: Text(
                                            '( ' +
                                                widget.gradescount.toString() +
                                                ' )',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 250,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('menu')
                    .where("storeName", isEqualTo: widget.storeName)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Container(
                            height: 70,
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
                            child: Center(
                              child: ListTile(
                                leading: Image.network(
                                  documentSnapshot['imageUrl'],
                                  height: 120,
                                  fit: BoxFit.fitHeight,
                                ),
                                title: Text(documentSnapshot['name']),
                                trailing: Text(
                                  documentSnapshot['price'] + '원',
                                ),
                                onTap: () async {
                                  bool itemExists = await checkItemExists(
                                      documentSnapshot['name'], user!.uid);
                                  if (!itemExists) {
                                    await product.add({
                                      'storeName': widget.storeName,
                                      'name': documentSnapshot['name'],
                                      'price': documentSnapshot['price'],
                                      'location': widget.areaName,
                                      'userUid': user!.uid,
                                      'storeUid': documentSnapshot['storeUid'],
                                      'imageUrl': documentSnapshot['imageUrl'],
                                      'count': 1,
                                    });
                                    final result =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Cart(),
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        CartCount();
                                        OrderCount();
                                      });
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text("이미 장바구니에 있어요!!"),
                                          actions: [
                                            TextButton(
                                              child: Text("확인"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // 다이얼로그 닫기
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
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
                    final result = await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AreaSearch()),
                      (route) => false,
                    );
                    if (result != null) {
                      setState(() {
                        CartCount();
                        OrderCount();
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
                        OrderCount();
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
                        OrderCount();
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
                        OrderCount();
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
                        OrderCount();
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
        await product.where('userUid', isEqualTo: user!.uid).get();

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
