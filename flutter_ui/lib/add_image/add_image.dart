import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage(this.addImageFunc, {super.key});

  final Function(Uint8List pickedImage) addImageFunc;

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
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
      widget.addImageFunc(webImage);
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
            label: const Text('Add icon'),
          ),
          const SizedBox(
            height: 80,
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
            label: const Text('close'),
          )
        ],
      ),
    );
  }
}
