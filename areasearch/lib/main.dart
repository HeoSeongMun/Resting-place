import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50,),
          Row(
            children:[
              Container(
                width: 260,
                height: 30,
                margin: EdgeInsets.only(left: 50),
                child:
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFAAC4FF),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width:2,
                          color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width:2,
                          color: Colors.black12),
                    ),
                    border: OutlineInputBorder(
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.only(left: 50),
            child: Text("검색된 휴게소",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 50),
            height: 480,
            width: 290,
            color: Color(0xFFAAC4FF),
            child: ListView.separated(
              padding: const EdgeInsets.all(5),
                itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 70,
                  color: Colors.white,
                  child: Center(child: Text('item : $index')),
                );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemCount: 7,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
            color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.home,color: Colors.black,),
              Icon(Icons.man,color: Colors.black,),
              Icon(Icons.search,color: Colors.black,),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
