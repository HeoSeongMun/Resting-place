import 'package:flutter/material.dart';
import 'package:flutter_app/cart.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/menu.dart';
import 'package:flutter_app/orderedlist.dart';
import 'package:flutter_app/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant extends StatelessWidget {
  Restaurant(this.areaName, this.imageUrl, {super.key});

  String areaName = '';
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                            Navigator.pop(context);
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
                        imageUrl,
                        height: 150,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      areaName,
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
              height: MediaQuery.of(context).size.height - 390,
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
                      .where("restAreaName", isEqualTo: areaName)
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
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Menu(
                                        areaName,
                                        documentSnapshot['storeName'],
                                        documentSnapshot['storeimageUrl']
                                            .toString()),
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
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
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
      ),
    );
  }
}
