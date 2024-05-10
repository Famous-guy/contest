
import 'package:image_picker/image_picker.dart';


class OpenCamera {
  final ImagePicker _picker = ImagePicker();

  Future<String> pickCamera({ImageSource? source}) async {
    XFile? image =
    await _picker.pickImage(source: source ?? ImageSource.camera);

    if (image != null) {
      return image.path;
    } else {
      return '';
    }
  }
  final ImagePicker picker = ImagePicker();

  Future<List<String>> pickMultipleImages({ImageSource? source}) async {
    List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70,
    );

    if (images != null) {
      return images.map((image) => image.path).toList();
    } else {
      return []; // Return an empty list if no images are selected
    }
  }


  Future<String> pickVideo({ImageSource? source}) async {
    XFile? image =
    await _picker.pickVideo(source: source ?? ImageSource.camera);

    if (image != null) {
      return image.path;
    } else {
      return '';
    }
  }
}


