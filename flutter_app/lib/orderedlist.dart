import 'package:flutter/material.dart';

class OrderedList extends StatelessWidget {
  OrderedList({super.key});

  List<String> _restAreaName = ['영종대교휴게소(서울행)', '영종대교휴게소(서울행)', '시흥하늘휴게소(양방향)'];
  List<String> _orderDateTime = [
    '2023/01/10 09:31',
    '2023/01/10 09:21',
    '2023/01/3 10:31'
  ];
  List<String> _storeName = ['영종분식', '마미손', '서화일식'];
  List<String> _menuName = ['떡볶이/튀김 세트', '잡채밥', '돈까스'];
  List<String> _totPrice = ['12000', '20000', '30000'];
  List<String> _orderStatus = ['조리중', '조리완료', '완료'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffAAC4FF),
          title: Text('주문내역',
              style: TextStyle(
                color: Colors.black,
              )),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView.separated(
            padding: const EdgeInsets.all(10.0),
            itemCount: _storeName.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 150,
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 150,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_restAreaName[index],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                    _orderDateTime[index],
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    _storeName[index],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    _menuName[index],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    _totPrice[index] + '원',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        width: 60,
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Text(
                                _orderStatus[index],
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Container(
                        width: 80,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                '상세 주문',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffAAC4FF),
                              ),
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                //주문상태에 따라서 표시되는 버튼과 텍스트 변경이 되야함.
                              },
                              child: Text(
                                '기능 요구',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff92ABEB),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  height: 10,
                  color: Colors.black,
                )));
  }
}
