import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/add_image/add_image.dart';
import 'package:flutter_ui/login.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  Uint8List? userPickedImage;

  void pickedImage(Uint8List image) {
    userPickedImage = image;
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: AddImage(pickedImage),
        );
      },
    );
  }

  final _authentication = FirebaseAuth.instance;

  // 텍스트 폼 필드 테스트 (이건 지워도됨)
  String userId = "";
  String userPw = "";

  CollectionReference product =
      FirebaseFirestore.instance.collection('testlogin');

  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController directionController = TextEditingController();
  final TextEditingController storenameController = TextEditingController();
  final TextEditingController restareanameController = TextEditingController();
  final TextEditingController biznumberController = TextEditingController();
  final TextEditingController ownernameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  //final TextEditingController addressController = TextEditingController(); // 주소 입력

  // 테스트
  Future<void> update(DocumentSnapshot documentSnapshot) async {
    idController.text = documentSnapshot['name'];
    pwController.text = documentSnapshot['price'];
  }

  // 테스트
  Future<void> create() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 700,
                  height: 1000,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 70, 50, 70),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: idController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '닉네임',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '이메일',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          obscureText: true,
                          controller: pwController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '비밀번호',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: restareanameController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(
                                  r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]'),
                            ),
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '휴게소 이름을 적어주세요 예) "ㅁㅁ휴게소"',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: directionController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '어느 방향 고속도로인지 적어주세요 예)서울방향, 부산방향',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: storenameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '가게 이름을 적어주세요',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: biznumberController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '사업자 번호를 적어주세요',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: ownernameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '요청자 이름을 적어주세요',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: phonenumberController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '요청자 전화번호를 적어주세요 예)01012341234',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size(1000, 60),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            try {
                              /*
                                    //회원가입부분
                                    final newUser = await _authentication
                                        .createUserWithEmailAndPassword(
                                      email: emailController.text,
                                      password: pwController.text,
                                    );
                                    */
                              //사진 넣는 부분
                              /*
                                    final String storename = storenameController.text;
                                    final refImage = FirebaseStorage.instance
                                        .ref()
                                        .child('waitImage')
                                        .child('$storename.png');
                                    
                                    await refImage.putData(userPickedImage!);
                                    final imageUrl = await refImage.getDownloadURL();
                                    */
                              await FirebaseFirestore.instance
                                  .collection('admin_request')
                                  .add(
                                {
                                  'owner_nickname': idController.text,
                                  'owner_email': emailController.text,
                                  'owner_password': pwController.text,
                                  'restarea_name': restareanameController.text,
                                  'direction': directionController.text,
                                  'store_name': storenameController.text,
                                  'biz_number': biznumberController.text,
                                  'owner_name': ownernameController.text,
                                  'phone_number': phonenumberController.text,
                                  //'addressController': addressController, //주소 입력
                                },
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Login();
                                  },
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('이메일과 비밀번호를 확인해주세요'),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                            }
                          },
                          child: const Text('요청하기'),
                        ),
                      ],
                    ),
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
