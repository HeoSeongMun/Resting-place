import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPage extends StatefulWidget {
  const NumberPage({super.key});

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  var hour = 0;
  var minute = 0;
  var timeFormat = "오전";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "도착 예상 시간을 정해주세요! ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, "0")} ${timeFormat}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                    textStyle: TextStyle(color: Colors.grey[400], fontSize: 20),
                    selectedTextStyle:
                        TextStyle(color: Colors.black, fontSize: 30),
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                            color: Colors.white,
                          ),
                          bottom: BorderSide(color: Colors.white)),
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
                    textStyle: TextStyle(color: Colors.grey[400], fontSize: 20),
                    selectedTextStyle:
                        TextStyle(color: Colors.black, fontSize: 30),
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                            color: Colors.white,
                          ),
                          bottom: BorderSide(color: Colors.white)),
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            timeFormat = "오전";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: timeFormat == "오전"
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade700,
                              border: Border.all(
                                color: timeFormat == "오전"
                                    ? Colors.grey
                                    : Colors.grey.shade700,
                              )),
                          child: const Text(
                            "오전",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            timeFormat = "오후";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: timeFormat == "오후"
                                ? Colors.grey.shade800
                                : Colors.grey.shade700,
                            border: Border.all(
                              color: timeFormat == "오후"
                                  ? Colors.grey
                                  : Colors.grey.shade700,
                            ),
                          ),
                          child: const Text(
                            "오후",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
