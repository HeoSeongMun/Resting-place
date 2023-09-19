import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<StatefulWidget> createState() => _Delivery();
}

class _Delivery extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    var records;
    double percent = records?.last.distance ?? 3 / 10;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 80, right: 50, top: 50),
                child: Column(
                  children: [],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
