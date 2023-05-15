import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              height: 50,
              color: Color(0xFFAAC4FF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0, right: 0),
                    width: 60,
                    height: 60,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 35,
                      color: Color.fromARGB(255, 0, 0, 0),
                      onPressed: () {},
                    ),
                  ),
                  Text(
                    "장바구니",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 30,
                    margin: EdgeInsets.only(left: 190),
                    child: ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          primary: Colors.black,
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          side: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "전체삭제",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.8,
              color: Colors.black,
            ),
            Container(
              height: 100,
              color: Color(0xFFAAC4FF),
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "뚱스 부대찌개",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "영종대교휴게소(서울방면)",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1.5,
              color: Colors.black,
            ),
            Container(
              height: 400,
              color: Colors.white,
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
            Container(
              height: 100,
              color: Color(0xFFAAC4FF),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 15, top: 20),
                  child: Text(
                    "총 주문 금액",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 170, top: 50),
                  child: Text(
                    "25,500원",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  minimumSize: Size(400, 50),
                  primary: Colors.black,
                  backgroundColor: Color(0xFFB1B2FF),
                  side: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "주문하기",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
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
