import 'package:flutter/material.dart';
import 'package:flutter_app/payment.dart';

class Cart extends StatelessWidget {
  Cart({super.key});

  final List<String> ImageList = [];
  final List<String> TitleList = [];
  final List<String> MoneyList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
                itemCount: TitleList.length,
                padding: const EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(TitleList[index]),
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset(ImageList[index]),
                    ),
                    trailing: Text(MoneyList[index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
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
                    "0원",
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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Payment(),
                    ),
                  );
                },
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
