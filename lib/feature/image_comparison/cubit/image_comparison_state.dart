part of 'image_comparison_cubit.dart';

enum ImageComparisonStatus { success, error, loading, initial }

class ImageComparisonState {
  final XFile? firstImageFile;
  final XFile? secondImageFile;
  final Uint8List? highlightedEncodedImage;
  final double? differencePercent;
  final ImageComparisonStatus status;

  ImageComparisonState({
    required this.status,
    this.firstImageFile,
    this.differencePercent,
    this.secondImageFile,
    this.highlightedEncodedImage,
  });

  bool get firstImageNotNull => firstImageFile != null;
  bool get secondImageNotNull => secondImageFile != null;
  bool get imageNotNull => firstImageNotNull && secondImageNotNull;
}
