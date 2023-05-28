import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/menu.dart';
import 'package:flutter_app/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant extends StatelessWidget {
  Restaurant({super.key});

  CollectionReference product =
      FirebaseFirestore.instance.collection('restaurant');
  CollectionReference product1 = FirebaseFirestore.instance.collection('area');

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              height: 80,
              color: Color(0xFFAAC4FF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.restaurant_outlined,
                      size: 45,
                      color: Colors.indigo[700],
                    ),
                  ),
                  Container(
                    child: StreamBuilder(
                      stream: product1.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          final docs = streamSnapshot.data!.docs[0];
                          return Text(
                            docs['location'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.star_outline,
                      size: 45,
                    ),
                    color: Colors.indigo[700],
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
                stream: product.snapshots(),
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
                              title: Text(documentSnapshot['store']),
                              subtitle: Text(documentSnapshot['kind']),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Menu(),
                                  ),
                                );
                              },
                            ),
                          );
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
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
                  icon: Icon(Icons.home),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  }),
              IconButton(
                icon: Icon(
                  Icons.man,
                ),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                },
              ),
              IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AreaSearch()),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
