import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageController {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future<File?> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
    }

    return selectedImage;
  }

  void clearImage() {
    selectedImage = null;
  }
}
