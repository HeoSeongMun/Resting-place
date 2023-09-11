import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'completepayment.dart';

class Payment extends StatefulWidget {
  const Payment({required this.total, super.key});

  final String total;
  State<Payment> createState() => _Payment();
}

class _Payment extends State<Payment> {

  String name = '';
  String price = '';
  String storeName = '';
  String location = '';
  String storeUid = '';
  String userUid = '';
  String total = '';

  int mileage = 0;
  int discount = 0;
  int finalprice = 0;
  int saveMileage = 0;

  var hour = 0;
  var minute = 0;
  var timeFormat = '오전';
  String arrivalTime = '';

  CollectionReference SBproduct =
      FirebaseFirestore.instance.collection('shoppingBasket');

  CollectionReference order = FirebaseFirestore.instance.collection('order');

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    total = widget.total; //전 화면에서 받아온 total 데이터값을 현재 클래스로 불러옴
    finalprice = int.parse(total);
    getMileageData();
  }
  Future<void> setMileageData() async {
    final userSnapshot = await FirebaseFirestore.instance
            .collection('userinfo')
            .where('userUid', isEqualTo: user!.uid) // 필드 이름과 원하는 값으로 변경하세요.
            .get();
    if (userSnapshot.docs.isNotEmpty) {
      final userDocument = userSnapshot.docs.first;
      final userDocumentId = userDocument.id;
      finalprice = int.parse(total) - discount;
      saveMileage = (finalprice / 100 * 5).toInt();
      final updateData = {
        'mileage': saveMileage + (mileage - discount)
      };

      await FirebaseFirestore.instance
            .collection('userinfo')
            .doc(userDocumentId)
            .update(updateData);
    }
    
  }

  Future<void> getMileageData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('userinfo')
        .where('userUid', isEqualTo: user!.uid) // 필드 이름과 원하는 값으로 변경하세요.
        .get();

    if (snapshot.docs.isNotEmpty) {
      final firstDocument = snapshot.docs[0];
      final mileageValue = firstDocument.data()['mileage'];

      setState(() {
        mileage = mileageValue;
      });
    }
  }

  void showInputDialog(BuildContext context) {
    TextEditingController mileageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('사용 가능 마일리지 금액 : $mileage'),          
          content: TextField(
            keyboardType: TextInputType.number,
            controller: mileageController,
            decoration: InputDecoration(
              hintText: '사용할 마일리지 금액를 입력하세요.',
            ),
          ),
          actions: <Widget> [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                if (int.parse(mileageController.text) > mileage) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('금액 한도 초과'),
                        content: Text('입력된 금액이 보유 마일리지 금액을 초과합니다.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('확인'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (int.parse(mileageController.text) > int.parse(total)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('금액 초과'),
                        content: Text('입력된 금액이 결제 금액을 초과합니다.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('확인'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  setState(() {
                  discount = int.parse(mileageController.text);
                  finalprice = int.parse(total) - discount;                  
                });                
                Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Container(
              height: 50,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 0, right: 0),
                    width: 60,
                    height: 60,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 35,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 1.3,
              width: 390,
              color: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 40, right: 15),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: const [
                      Text(
                        "주문금액",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 230,
                  ),
                  Column(
                    children: [
                      Text(
                        '$total원',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 1.5,
              width: 390,
              color: Colors.black26,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "총 할인금액",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    '$discount원',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration: const BoxDecoration(
                color: Color(0xFFD2DAFF),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "내 마일리지",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '$mileage원',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 130),
                      width: 50,
                      height: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          backgroundColor: const Color(0xFFEEF1FF),
                          side: const BorderSide(
                            color: Color(0xFFEEF1FF),
                            width: 1,
                          ),
                        ),
                        onPressed: () {
                          showInputDialog(context);
                        },
                        child: const Text(
                          "사용",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            //여기서 추가
          const SizedBox(height: 10,),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              height: 40,
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "도착 예상 시간 : ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, "0")} ${timeFormat}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13
                      ),
                    ),
                    const SizedBox(width: 30,),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        backgroundColor: const Color(0xFFEEF1FF),
                        side: const BorderSide(
                          color: Color(0xFFEEF1FF),
                          width: 1
                        ),                        
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text(
                                '도착 예상 시간을 정해주세요.',
                                style: TextStyle(color: Colors.black),
                              ),
                              content: StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                return Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      NumberPicker(
                                        minValue: 0,
                                        maxValue: 12,
                                        value: hour,
                                        zeroPad: true,
                                        infiniteLoop: true,
                                        itemWidth: 80,
                                        itemHeight: 60,
                                        onChanged: (value) {
                                          setState(() {
                                            hour = value;
                                          });
                                        },
                                        textStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 20
                                        ),
                                        selectedTextStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30
                                        ),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.white,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.white
                                            )
                                          )
                                        ),
                                      ),
                                      NumberPicker(
                                        minValue: 0,
                                        maxValue: 59,
                                        value: minute,
                                        zeroPad: true,
                                        infiniteLoop: true,
                                        itemWidth: 80,
                                        itemHeight: 60,
                                        onChanged: (value) {
                                          setState(() {
                                            minute = value;
                                          });
                                        },
                                        textStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 20
                                        ),
                                        selectedTextStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30
                                        ),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.white,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.white
                                            )
                                          )
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                timeFormat = '오전';
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 10
                                              ),
                                              decoration: BoxDecoration(
                                                color: timeFormat == '오전'
                                                ? Colors.grey.shade800
                                                : Colors.grey.shade700,
                                                border: Border.all(
                                                  color: timeFormat == '오전'
                                                  ? Colors.grey
                                                  : Colors.grey.shade700,
                                                )
                                              ),
                                              child: const Text(
                                                '오전',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15,),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                timeFormat = '오후';
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 10
                                              ),
                                              decoration: BoxDecoration(
                                                color: timeFormat == '오후'
                                                ? Colors.grey.shade800
                                                : Colors.grey.shade700,
                                                border: Border.all(
                                                  color: timeFormat == '오후'
                                                  ? Colors.grey
                                                  : Colors.grey.shade700,
                                                )
                                              ),
                                              child: const Text(
                                                '오후',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                          }),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text('취소'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  hour = hour;
                                  minute = minute;
                                  timeFormat = timeFormat;
                                });
                                Navigator.pop(context, false);
                              },
                              child: Text('확인'),
                            )
                          ],
                            );
                          }
                        );
                      },
                      child: const Text(
                        "예상시간\n 선택",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ), 
            const SizedBox(height: 10,), //원래는 높이 40
            //여기까지
            Container(
              height: 1.5,
              width: 390,
              color: Colors.black26,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration: const BoxDecoration(
                color: Color(0xFFD2DAFF),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "결제 금액",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$finalprice원',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 1.8,
              width: 390,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 25, top: 10, bottom: 20),
              child: const Text(
                "결제 수단",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              height: 130,
              child: IconButton(
                onPressed: () {
                  debugPrint("터치");
                },
                icon: Image.asset(
                  'assets/images/kakaopay.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 119,
                      height: double.infinity,
                      color: Colors.grey,
                      child: const Text(
                        "취소",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      arrivalTime = '$timeFormat $hour시 $minute분';

                      Query query =
                          SBproduct.where('userUid', isEqualTo: user!.uid);
                      QuerySnapshot querySnapshot = await query.get();
                      List<QueryDocumentSnapshot> documents =
                          querySnapshot.docs;
                      for (QueryDocumentSnapshot document in documents) {
                        // 'name', 'price', 'storeName' 필드 값 가져오기
                        name = document.get('name');
                        price = document.get('price');
                        storeName = document.get('storeName');
                        storeUid = document.get('storeUid');
                        userUid = document.get('userUid');
                      }
                      await order.add({
                        'name': name,
                        'price': price,
                        'storeName': storeName,
                        'storeUid': storeUid,
                        'userUid': userUid,
                        'arrivalTime': arrivalTime,
                      });
                      setMileageData();
                      //유저 uid 비교해서 해당하는 문서 삭제

                      for (QueryDocumentSnapshot document in documents) {
                        await document.reference.delete();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PayComplete(total, discount, finalprice, saveMileage)),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 292.3,
                      height: double.infinity,
                      color: const Color(0xFFB1B2FF),
                      child: const Text(
                        "결제",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
