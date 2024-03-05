import 'package:bloc/bloc.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageState('firstImage', 'secondImage'));
}
