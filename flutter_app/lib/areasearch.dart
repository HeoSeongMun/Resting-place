import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/restaurant.dart';

import 'areaitem.dart';

class AreaSearch extends StatelessWidget {
  AreaSearch({super.key});

  static List<String> ImageList = [
    'assets/images/menu1.jpg',
    'assets/images/menu2.jpg',
    'assets/images/menu3.png'
  ];
  static List<String> AreaList = ['영종대교휴게소(서울행)', '서울 만남의광장 휴게소', '휴게소3'];
  static List<String> DistanceList = ['14.2km', '10.5km', '20.7km'];

  final List<Area> areaDate = List.generate(AreaList.length,
      (index) => Area(ImageList[index], AreaList[index], DistanceList[index]));

  Widget build(BuildContext context) {
    return MaterialApp(
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
                    width: 260,
                    height: 30,
                    margin: EdgeInsets.only(left: 50),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFAAC4FF),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.black12),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  "검색된 휴게소",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50),
                height: 520,
                width: 290,
                color: Color(0xFFD2DAFF),
                child: ListView.builder(
                  itemCount: areaDate.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(areaDate[index].area),
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset(areaDate[index].imgPath),
                        ),
                        trailing: Text(areaDate[index].distance),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Restaurant(
                                    area: areaDate[index],
                                  )));
                        },
                      ),
                    );
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
      ),
    );
  }
}
