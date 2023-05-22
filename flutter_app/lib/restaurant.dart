import 'package:flutter/material.dart';
import 'package:flutter_app/areaitem.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/areasearch.dart';
import 'package:flutter_app/menu.dart';

import 'restitem.dart';

class Restaurant extends StatelessWidget {
  Restaurant({Key? key, required this.area}) : super(key: key);

  final Area area;

  static List<String> ImageList = [
    'assets/images/menu1.jpg',
    'assets/images/menu2.jpg',
    'assets/images/menu3.png'
  ];
  static List<String> RestaurntList = ['말죽거리 한식당', '코바코 돈까스', '명가네 가락우동'];
  static List<String> FoodTypeList = ['한식', '일식', '양식'];

  final List<Rest> restDate = List.generate(
      RestaurntList.length,
      (index) =>
          Rest(ImageList[index], RestaurntList[index], FoodTypeList[index]));

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
                    area.area,
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
                itemCount: restDate.length,
                padding: const EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(restDate[index].rest),
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset(restDate[index].imgPath),
                    ),
                    trailing: Text(restDate[index].type),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Menu(
                            rest: restDate[index],
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
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
