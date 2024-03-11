import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:solid_test/widget/primary_elevated_button.dart';

class ImageSelect extends StatelessWidget {
  final bool showImage;
  final String? imagePath;
  final String buttonTitle;
  final VoidCallback buttonCallback;

  const ImageSelect({
    required this.showImage,
    required this.imagePath,
    required this.buttonTitle,
    required this.buttonCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Visibility(
        visible: showImage,
        replacement: PrimaryElevatedButton(
          title: buttonTitle,
          onPressed: buttonCallback,
        ),
        child: ImageWidget(imagePath: imagePath),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String? imagePath;
  const ImageWidget({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return const Text('No Image Selected');
    } else {
      return kIsWeb
          ? Image.network(imagePath!)
          : Image.file(
              File(imagePath!),
            );
    }
  }
}
