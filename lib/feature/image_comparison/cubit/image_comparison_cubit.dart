import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solid_test/feature/image_comparison/model/compare_images_params.dart';
import 'package:solid_test/feature/image_comparison/model/image_comparison_result.dart';

part 'image_comparison_state.dart';

class ImageComparisonCubit extends Cubit<ImageComparisonState> {
  ImageComparisonCubit()
      : super(ImageComparisonState(status: ImageComparisonStatus.initial));

  final ImagePicker _picker = ImagePicker();

  Future<void> pickFirstImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      emit(
        ImageComparisonState(
          firstImageFile: pickedImage,
          secondImageFile: state.secondImageFile,
          status: ImageComparisonStatus.initial,
        ),
      );
    }
  }

  Future<void> pickSecondImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      emit(
        ImageComparisonState(
          firstImageFile: state.firstImageFile,
          secondImageFile: pickedImage,
          status: ImageComparisonStatus.initial,
        ),
      );
    }
  }

  Future<void> compareImages() async {
    emit(
      ImageComparisonState(
        firstImageFile: state.firstImageFile,
        secondImageFile: state.secondImageFile,
        status: ImageComparisonStatus.loading,
      ),
    );

    final imageData1 = await state.firstImageFile!.readAsBytes();
    final imageData2 = await state.secondImageFile!.readAsBytes();
    final params = CompareImagesParams(imageData1, imageData2);

    final result = await compute(compareImagesInIsolate, params);

    if (result.error) {
      emit(
        ImageComparisonState(
          firstImageFile: state.firstImageFile,
          secondImageFile: state.secondImageFile,
          status: ImageComparisonStatus.error,
        ),
      );
    } else {
      emit(
        ImageComparisonState(
          firstImageFile: state.firstImageFile,
          secondImageFile: state.secondImageFile,
          highlightedEncodedImage: result.highlightedEncodedImage,
          status: ImageComparisonStatus.success,
          differencePercent: result.differencePercent,
        ),
      );
    }
  }

  void cleanImageState() {
    emit(ImageComparisonState(status: ImageComparisonStatus.initial));
  }
}

Future<ImageComparisonResult> compareImagesInIsolate(
  CompareImagesParams params,
) async {
  final Uint8List imageData1 = params.imageData1;
  final Uint8List imageData2 = params.imageData2;

  final Image image1 = decodeImage(imageData1)!;
  final Image image2 = decodeImage(imageData2)!;

  double difference = 0;
  int differentPixel = 0;

  if (image1.width != image2.width || image1.height != image2.height) {
    return ImageComparisonResult(error: true);
  } else {
    for (int y = 0; y < image1.height; y++) {
      for (int x = 0; x < image1.width; x++) {
        if (image1.getPixel(x, y) != image2.getPixel(x, y)) {
          image2.setPixel(x, y, ColorRgba8(255, 0, 0, 255));
          differentPixel++;
        }
      }
    }
    difference = (differentPixel * 100) / (image1.height * image1.width);
    return ImageComparisonResult(
      differencePercent: difference,
      highlightedEncodedImage: Uint8List.fromList(encodeJpg(image2)),
    );
  }
}
