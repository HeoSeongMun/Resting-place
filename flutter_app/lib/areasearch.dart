import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/restaurant.dart';

class AreaSearch extends StatelessWidget {
  AreaSearch({super.key});

  final List<String> ImageList = [
    'assets/images/menu1.jpg',
    'assets/images/menu2.jpg',
    'assets/images/menu3.png'
  ];

  final List<String> TitleList = ['영종대교휴게소(서울행)', '메뉴2', '메뉴3'];
  final List<String> DistanceList = ['14.2km', '10.5km', '20.7km'];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                      borderSide: BorderSide(width: 2, color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black12),
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
            height: 480,
            width: 290,
            color: Color(0xFFAAC4FF),
            child: ListView.separated(
              padding: const EdgeInsets.all(5),
              itemBuilder: (BuildContext context, int index) {
                return _buildListItem(context, ImageList[index],
                    TitleList[index], DistanceList[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                );
              },
              itemCount: ImageList.length,
            ),
          ),
        ],
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

Widget _buildListItem(
    BuildContext context, String imageUrl, String title, String distance) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      leading: Image.asset(
        imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        distance,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Restaurant()));
      },
    ),
  );
}
