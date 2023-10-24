import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveryListItem extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> documentSnapshot;

  const DeliveryListItem({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  _DeliveryListItem createState() => _DeliveryListItem();
}

class _DeliveryListItem extends State<DeliveryListItem> {
  bool isExpanded = false;

  String formatTimestamp(Timestamp timestamp) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final formattedDateTime = dateFormat.format(
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
    return formattedDateTime;
  }

  double getProgressIndicator(String status) {
    switch (status) {
      case '주문중':
        return 0.33;
      case '조리중':
        return 0.66;
      case '조리완료':
        return 1.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        widget.documentSnapshot;

    String orderTime = formatTimestamp(documentSnapshot['ordertime']);
    String price =
        (int.parse(documentSnapshot['price']) * documentSnapshot['count'])
            .toString();
    double indicatorValue = getProgressIndicator(documentSnapshot['status']);
    String formattime = '';
    DateTime? cookingTime =
        documentSnapshot.data()?['Cookingtime']?.toDate() as DateTime?;

    if (cookingTime != null) {
      DateTime dateTime = documentSnapshot['Cookingtime'].toDate();
      formattime = DateFormat('aa HH시mm분')
          .format(dateTime)
          .replaceAll("AM", "오전")
          .replaceAll("PM", "오후");
    } else {
      formattime = '';
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      decoration: BoxDecoration(
          color: const Color(0xFFD2DAFF),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 5,
              spreadRadius: 0,
              offset: const Offset(0, 7),
            ),
          ]),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: documentSnapshot['name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 17)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.5,
                  color: Colors.grey,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      documentSnapshot['status'], //주문 상태 표시
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    height: 15,
                    child: LinearProgressIndicator(
                      value: getProgressIndicator(documentSnapshot['status']),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xffFFB79E),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isExpanded =
                              !isExpanded; // 텍스트 버튼을 누를 때마다 확장/접기 상태 변경
                        });
                      },
                      child: isExpanded
                          ? const Text(
                              '▽ 주문정보 닫기 ▽',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black54),
                            )
                          : const Text(
                              '▽ 주문정보 열기 ▽',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black54),
                            ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: isExpanded ? null : 0,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width - 200,
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width:
                                        MediaQuery.of(context).size.width - 200,
                                    child: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        const TextSpan(
                                          text: '주문 일자 :  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        TextSpan(
                                            text: orderTime,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ]),
                                    )),
                                const SizedBox(height: 10),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width:
                                        MediaQuery.of(context).size.width - 200,
                                    child: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        const TextSpan(
                                            text: '휴게소 명 :  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: documentSnapshot['area_name'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ]),
                                    )),
                                const SizedBox(height: 10),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width:
                                        MediaQuery.of(context).size.width - 200,
                                    child: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        const TextSpan(
                                            text: '점포 명 :  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: documentSnapshot['storeName'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ]),
                                    )),
                                const SizedBox(height: 10),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width:
                                        MediaQuery.of(context).size.width - 200,
                                    child: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        const TextSpan(
                                            text: '메뉴 이름 :  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: documentSnapshot['name'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text:
                                                ' ${documentSnapshot['count']}개',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ]),
                                    )),
                                const SizedBox(height: 10),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width:
                                        MediaQuery.of(context).size.width - 200,
                                    child: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        const TextSpan(
                                            text: '주문 금액 :  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: '$price ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        const TextSpan(
                                            text: '원',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ]),
                                    )),
                                const SizedBox(height: 10),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width:
                                        MediaQuery.of(context).size.width - 200,
                                    child: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        const TextSpan(
                                            text: '주문 번호 :  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: documentSnapshot[
                                                    'ordernumber'] +
                                                ' ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ]),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              child: Column(
                                children: [
                                  Container(
                                    child: const Center(
                                      child: Text(
                                        '조리완료\n예상시간',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        formattime,
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          const SizedBox(width: 20)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
