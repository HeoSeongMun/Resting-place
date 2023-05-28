import 'package:flutter/material.dart';

class UserInfoEditScreen extends StatelessWidget {
  UserInfoEditScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('사용자 정보 수정'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            '이름',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(),
          ),
        ],
      )),
    );
  }
}
