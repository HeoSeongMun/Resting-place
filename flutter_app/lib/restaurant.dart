import 'package:flutter/material.dart';
import 'package:flutter_app/cart.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/menu.dart';
import 'package:flutter_app/orderedlist.dart';
import 'package:flutter_app/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant extends StatelessWidget {
  Restaurant(this.areaName, {super.key});

  String areaName = '';

  CollectionReference product =
      FirebaseFirestore.instance.collection('restaurant');
  CollectionReference product1 = FirebaseFirestore.instance.collection('area');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFAAC4FF),
              height: 30,
            ),
            Container(
              height: 80,
              color: const Color(0xFFAAC4FF),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.restaurant_outlined,
                        size: 45,
                        color: Colors.indigo[700],
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
                    .collection('testlogin')
                    .where("restAreaName", isEqualTo: areaName)
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
                          child: ListTile(
                            title: Text(documentSnapshot['storeName']),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Menu(
                                      areaName, documentSnapshot['storeName']),
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
    );
  }
}
