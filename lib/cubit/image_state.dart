part of 'image_cubit.dart';

class ImageState {
  String firstImage;
  String secondImage;

  ImageState(this.firstImage, this.secondImage);

  List<Object> get props => [firstImage, secondImage];
}
