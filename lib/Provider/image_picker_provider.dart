import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

class ImagePickerProvider with ChangeNotifier {
  File? selectedImage;

  // Getter for the selected image
  // File? get selectedImage => _selectedImage;

  // Function to pick and optionally crop an image
  Future<void> pickAndCropImage({required ImageSource source}) async {
    try {
      final picker = ImagePicker();

      // Step 1: Pick an image
      final XFile? pickedImage = await picker.pickImage(source: source);
      if (pickedImage == null) return; // User cancelled the picker

      File imageFile = File(pickedImage.path);

      // Step 2: Crop the image
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        // : [
        //   CropAspectRatioPreset.square,
        //   CropAspectRatioPreset.ratio3x2,
        //   CropAspectRatioPreset.original,
        //   CropAspectRatioPreset.ratio4x3,
        //   CropAspectRatioPreset.ratio16x9,
        // ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );

      if (croppedFile != null) {
        selectedImage = File(croppedFile.path); // Update the image state
        notifyListeners(); // Notify listeners to rebuild widgets
      }
    } catch (e) {
      print("Error picking or cropping image: $e");
    }
  }

  // Function to clear the selected image
  void clearImage() {
    selectedImage = null;
    notifyListeners();
  }
}
