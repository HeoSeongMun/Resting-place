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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 24,
          ),
          Container(
            height: 50,
            color: Color.fromARGB(255, 255, 255, 255),
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
              ],
            ),
          ),
          Container(
            height: 1.5,
            width: 360,
            color: Colors.black,
          ),
        ]),
      ),
    );
  }
}
