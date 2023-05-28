import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReview extends StatelessWidget {
  WriteReview({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffAAC4FF),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                color: Color(0xffAAC4FF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        '휴게소명',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        '매장명',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        '음식 또는 매장에 대해 평가를 해주세요.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 3,
                color: Colors.blue,
              ),
              SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 30,
                color: Color(0xffAAC4FF),
                child: Text(
                  '서비스와 맛은 어땠었나요?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 2,
                color: Colors.black,
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 30,
                color: Color(0xffAAC4FF),
                child: Text(
                  '좋은점과 부족한점을 적어주세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                height: 100,
                child: TextField(),
              ),
              ButtonTheme(
                  minWidth: 300,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('완 료'),
                  )),
            ],
          ),
        ));
  }
}
