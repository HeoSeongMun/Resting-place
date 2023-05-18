import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/areasearch.dart';

class Restaurant extends StatelessWidget {
  Restaurant({super.key});

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
                  Text(
                    "시흥하늘휴게소(양방향)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
              child: ListView.separated(
                padding: const EdgeInsets.all(5),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 70,
                    color: Colors.white,
                    child: Center(child: Text('item : $index')),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: 5,
              ),
            )
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
              Icon(
                Icons.man,
                color: Colors.black,
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
