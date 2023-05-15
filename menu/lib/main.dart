import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> ImageList = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.png'
  ];

  final List<String> TitleList = ['메뉴1', '메뉴2', '메뉴3'];
  final List<String> MoneyList = ['1000원', '1200원', '1400원'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      'assets/images/1.jpg',
                      height: 60,
                      width: 60,
                    ),
                  ),
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "말죽거리 한식당",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          margin: EdgeInsets.only(top: 5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            "시흥하늘휴게소(양방향)",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 1.8,
              color: Colors.black,
            ),
            Container(
              height: 560,
              color: Color.fromARGB(255, 255, 255, 255),
              child: ListView.separated(
                padding: const EdgeInsets.all(5),
                itemBuilder: (BuildContext context, int index) {
                  return _buildListItem(
                      ImageList[index], TitleList[index], MoneyList[index]);
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
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.home,
              color: Colors.black,
            ),
            Icon(
              Icons.man,
              color: Colors.black,
            ),
            Icon(
              Icons.search,
              color: Colors.black,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

Widget _buildListItem(String imageUrl, String title, String money) {
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
        money,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
