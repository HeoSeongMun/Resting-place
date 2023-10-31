import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Representative extends StatefulWidget {
  const Representative(this.representativeFunc, {super.key});

  final Function(Uint8List pickedImage) representativeFunc;

  @override
  State<Representative> createState() => _RepresentativeState();
}

Uint8List? userPickedImage;

void pickedImage(Uint8List image) {
  userPickedImage = image;
}

class _RepresentativeState extends State<Representative> {
  //File? pickedImage;
  Uint8List webImage = Uint8List(8);
  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        webImage = f;
      });
      widget.representativeFunc(webImage);
    }
    /*
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 150,
    );
    setState(
      () {
        if (pickedImageFile != null) {
          pickedImage = File(pickedImageFile.path);
        }
      },
    );
    widget.addImageFunc(pickedImage!);
  */
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: 150,
      height: 300,
      child: Column(
        children: [
          CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Image.memory(webImage, fit: BoxFit.fill)
              /*backgroundImage:
                pickedImage != null ? FileImage(pickedImage!) : null,*/
              ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton.icon(
            onPressed: () {
              _pickImage();
            },
            icon: const Icon(Icons.image),
            label: const Text('대표이미지를 선택하고 닫으신다음 파란색 추가버튼을 누르세요!'),
          ),
          const SizedBox(
            height: 80,
          ),
          TextButton.icon(
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
            label: const Text('닫기'),
          )
        ],
      ),
    );
  }
}
