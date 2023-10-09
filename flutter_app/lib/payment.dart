import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'completepayment.dart';

class Payment extends StatefulWidget {
  const Payment({required this.total, super.key});

  final String total;
  @override
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
  String imageUrl = '';
  int count = 0;
  int mileage = 0;
  int discount = 0;
  int finalprice = 0;
  int saveMileage = 0;

  var hour = 0;
  var minute = 0;
  var timeFormat = '오전';
  String arrivalTime = '';
  late Timestamp ordertime;
  CollectionReference SBproduct =
      FirebaseFirestore.instance.collection('shoppingBasket');

  CollectionReference order = FirebaseFirestore.instance.collection('order');

  final user = FirebaseAuth.instance.currentUser;
  late bool isLoading = true;
  @override
  void initState() {
    super.initState();
    total = widget.total; //전 화면에서 받아온 total 데이터값
    finalprice = int.parse(total);
    getMileageData();
  }

  Future<void> setMileageData() async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('userinfo')
        .where('userUid', isEqualTo: user!.uid) // 필드 이름과 원하는 값으로 변경
        .get();
    if (userSnapshot.docs.isNotEmpty) {
      final userDocument = userSnapshot.docs.first;
      final userDocumentId = userDocument.id;
      finalprice = int.parse(total) - discount;
      saveMileage = (finalprice / 100 * 5).toInt();
      final updateData = {'mileage': saveMileage + (mileage - discount)};

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
                decoration: const InputDecoration(
                  hintText: '사용할 마일리지 금액를 입력하세요.',
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('확인'),
                  onPressed: () {
                    if (int.parse(mileageController.text) > mileage) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('금액 한도 초과'),
                            content: const Text('입력된 금액이 보유 마일리지 금액을 초과합니다.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('확인'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else if (int.parse(mileageController.text) >
                        int.parse(total)) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('금액 초과'),
                            content: const Text('입력된 금액이 결제 금액을 초과합니다.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('확인'),
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
                  child: const Text('취소'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }

  Future<String> generateOrderNumber() async {
    //주문 번호
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('order').get();
    int orderCount = querySnapshot.size; // 현재까지 저장된 주문의 개수
    String orderNumber = (orderCount + 1).toString(); // 새로운 주문 번호 생성
    return orderNumber;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Container(
                height: 40,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
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
                height: 10,
              ),
              Container(
                height: 1.3,
                width: 390,
                color: Colors.black,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: const Text(
                            "주문금액",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: Text(
                            '$total원',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: const Text(
                            "메뉴",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: const Text(
                            "갯수",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: const Text(
                            "금액",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Container(
                        height: 1.5,
                        width: 330,
                        color: Colors.black26,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 30,
                        right: 20,
                      ),
                      child: StreamBuilder(
                        stream: SBproduct.where('userUid', isEqualTo: user!.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> streamSnapshot) {
                          if (streamSnapshot.hasError) {
                            debugPrint('에러');
                            Container();
                          }
                          if (streamSnapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                final List<DocumentSnapshot> sortedDocs =
                                    List.from(streamSnapshot.data!.docs);
                                sortedDocs.sort((a, b) {
                                  num countA = a['count'];
                                  num countB = b['count'];
                                  return countA.compareTo(countB);
                                });
                                int itemPrice = int.parse(documentSnapshot[
                                    'price']); // 아이템의 가격 (int 형으로 가정)
                                int itemcount = documentSnapshot['count'];

                                int listlPrice = itemPrice * itemcount;
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: Text(
                                              sortedDocs[index]['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 100),
                                            child: Text(
                                              sortedDocs[index]['count']
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              '$listlPrice원',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 1.5,
                width: 390,
                color: Colors.black26,
              ),
              const SizedBox(
                height: 30,
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
                        style: const TextStyle(
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
              const SizedBox(
                height: 10,
              ),

              Container(
                margin: const EdgeInsets.only(left: 25, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "총 할인금액",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      '$discount원',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 1.5,
                width: 390,
                color: Colors.black26,
              ),
              //여기서 추가
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    '※도착시간을 정해주세요※',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                height: 40,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "도착 예상 시간 : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 130),
                        child: Text(
                          "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, "0")} $timeFormat",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.pink),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          backgroundColor: const Color(0xFFEEF1FF),
                          side: const BorderSide(
                              color: Color(0xFFEEF1FF), width: 1),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text(
                                    '도착 예상 시간을 정해주세요.',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  content: StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return SizedBox(
                                      height: 150,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                                fontSize: 20),
                                            selectedTextStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 30),
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(
                                                      color: Colors.white,
                                                    ),
                                                    bottom: BorderSide(
                                                        color: Colors.white))),
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
                                                fontSize: 20),
                                            selectedTextStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 30),
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(
                                                      color: Colors.white,
                                                    ),
                                                    bottom: BorderSide(
                                                        color: Colors.white))),
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 25),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      timeFormat = '오전';
                                                    });
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            timeFormat == '오전'
                                                                ? Colors.grey
                                                                    .shade800
                                                                : Colors.grey
                                                                    .shade700,
                                                        border: Border.all(
                                                          color:
                                                              timeFormat == '오전'
                                                                  ? Colors.grey
                                                                  : Colors.grey
                                                                      .shade700,
                                                        )),
                                                    child: const Text(
                                                      '오전',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      timeFormat = '오후';
                                                    });
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            timeFormat == '오후'
                                                                ? Colors.grey
                                                                    .shade800
                                                                : Colors.grey
                                                                    .shade700,
                                                        border: Border.all(
                                                          color:
                                                              timeFormat == '오후'
                                                                  ? Colors.grey
                                                                  : Colors.grey
                                                                      .shade700,
                                                        )),
                                                    child: const Text(
                                                      '오후',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                      child: const Text('취소'),
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
                                      child: const Text('확인'),
                                    )
                                  ],
                                );
                              });
                        },
                        child: const Text(
                          "예상시간\n\t\t 선택",
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
              const SizedBox(
                height: 10,
              ), //원래는 높이 40
              //여기까지
              Container(
                height: 1.5,
                width: 390,
                color: Colors.black26,
              ),
              const SizedBox(
                height: 20,
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
                            color: Colors.black,
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
                height: 20,
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
                margin: const EdgeInsets.only(left: 25, top: 5),
                child: const Text(
                  "결제 수단",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 280,
                height: 110,
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
                height: 20,
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 75,
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  arrivalTime = '$timeFormat $hour시 $minute분';

                  Query query =
                      SBproduct.where('userUid', isEqualTo: user!.uid);
                  QuerySnapshot querySnapshot = await query.get();
                  List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                  ordertime = Timestamp.now();
                  for (QueryDocumentSnapshot document in documents) {
                    // 'name', 'price', 'storeName' 필드 값 가져오기
                    name = document.get('name');
                    price = document.get('price');
                    location = document.get('location');
                    storeName = document.get('storeName');
                    storeUid = document.get('storeUid');
                    userUid = document.get('userUid');
                    imageUrl = document.get('imageUrl');
                    count = document.get('count');

                    String orderNumber = await generateOrderNumber();

                    await order.add({
                      'ordertime': ordertime.toDate(),
                      'area_name': location,
                      'name': name,
                      'price': price,
                      'status': '주문중',
                      'storeName': storeName,
                      'storeUid': storeUid,
                      'userUid': userUid,
                      'arrivalTime': arrivalTime,
                      'imageUrl': imageUrl,
                      'count': count,
                      'boolreview': false,
                      'ordernumber': orderNumber,
                    });
                  }

                  setMileageData();
                  //유저 uid 비교해서 해당하는 문서 삭제

                  for (QueryDocumentSnapshot document in documents) {
                    await document.reference.delete();
                  }
                  Future.delayed(const Duration(milliseconds: 100), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayComplete(total, discount,
                            finalprice, saveMileage, ordertime),
                      ),
                    );
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 292.3,
                  height: double.infinity,
                  color: const Color(0xffFFB79E),
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
      ),
    );
  }
}
