import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:solid_test/feature/image_comparison/cubit/image_comparison_cubit.dart';
import 'package:solid_test/feature/image_comparison/model/compare_images_params.dart';

void main() {
  test('Comparing identical images should return 0% difference', () async {
    final imageData1 =
        await File('test/resources/test_image_1.png').readAsBytes();
    final imageData2 =
        await File('test/resources/test_image_1.png').readAsBytes();
    final result = await compareImagesInIsolate(
        CompareImagesParams(imageData1, imageData2));

    expect(result.differencePercent, 0.0);
  });

  test('Comparing images with different sizes returns an error state',
      () async {
    final imageData1 =
        await File('test/resources/test_image_1.png').readAsBytes();
    final imageData2 =
        await File('test/resources/test_image_2.png').readAsBytes();
    final result = await compareImagesInIsolate(
        CompareImagesParams(imageData1, imageData2));

    expect(result.error, true);
  });

  test(
      'Comparing different images with the same dimensions should return a '
      'difference result greater than 0', () async {
    final imageData1 =
        await File('test/resources/test_image_1.png').readAsBytes();
    final imageData2 =
        await File('test/resources/test_image_3.png').readAsBytes();
    final result = await compareImagesInIsolate(
        CompareImagesParams(imageData1, imageData2));

    expect(result.differencePercent, greaterThan(0.0));
  });
}
