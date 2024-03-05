import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  img.Image? _highlightedImage;
  XFile? _imageFile1;
  XFile? _imageFile2;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Comparison Test'),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (_imageFile1 != null)
                  Image.file(File(_imageFile1!.path), width: 150, height: 150)
                else
                  OutlinedButton(
                    onPressed: () => _pickImage(1),
                    child: Text('Choose Image 1'),
                  ),
                if (_imageFile2 != null)
                  Image.file(File(_imageFile2!.path), width: 150, height: 150)
                else
                  OutlinedButton(
                    onPressed: () => _pickImage(2),
                    child: Text('Choose Image 2'),
                  ),
              ],
            ),
            if (_highlightedImage != null)
              Expanded(
                child: Center(
                  child: Image.memory(Uint8List.fromList(img.encodePng(_highlightedImage!))),
                ),
              ),
            Spacer(),
            ElevatedButton(
              onPressed: (_imageFile1 != null && _imageFile2 != null) ? _compareImages : null,
              child: Text('Compare Images'),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage(int imageNumber) async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        if (imageNumber == 1) {
          _imageFile1 = pickedImage;
        } else {
          _imageFile2 = pickedImage;
        }
      });
    }
  }

  void _compareImages() async {
    final highlightedImage = await highlightDifferences(_imageFile1!.path, _imageFile2!.path);
    setState(() {
      _highlightedImage = highlightedImage;
    });
  }

  Future<img.Image> highlightDifferences(String path1, String path2) async {
    img.Image image1 = img.decodeImage(File(path1).readAsBytesSync())!;
    img.Image image2 = img.decodeImage(File(path2).readAsBytesSync())!;

    if (image1.width != image2.width || image1.height != image2.height) {
      throw Exception('Images have different sizes');
    }

    for (int y = 0; y < image1.height; y++) {
      for (int x = 0; x < image1.width; x++) {
        if (image1.getPixel(x, y) != image2.getPixel(x, y)) {
          image2.setPixel(x, y, img.ColorRgb8(255, 0, 0));
        }
      }
    }

    return image2;
  }
}
