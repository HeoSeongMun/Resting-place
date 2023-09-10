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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffAAC4FF),
        title: Text('배송조회',
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
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 80, right: 50, top: 50),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 30, bottom: 5),
                      alignment: FractionalOffset(percent, 1 - percent),
                      child: FractionallySizedBox(
                        child: Image.asset('assets/images/appicon.png',
                            width: 30, height: 30, fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      child: LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        percent: percent,
                        lineHeight: 10,
                        backgroundColor: Colors.black38,
                        progressColor: Colors.indigo.shade900,
                        width: 350,
                      ),
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
