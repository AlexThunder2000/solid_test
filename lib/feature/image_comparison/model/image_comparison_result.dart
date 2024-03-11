import 'package:flutter/foundation.dart';

class ImageComparisonResult {
  final double differencePercent;
  final Uint8List? highlightedEncodedImage;
  final bool error;

  ImageComparisonResult({
    this.differencePercent = 0.0,
    this.highlightedEncodedImage,
    this.error = false,
  });
}
