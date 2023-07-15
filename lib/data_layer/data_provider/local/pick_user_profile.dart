import 'dart:developer';
import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk_a_tive/presentation/components/snackbar_widget.dart';

class PickUserProfile {
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "379449483728479",
    apiSecret: "P84yD201T01-JblVWczdP-1GB_Q",
    cloudName: "dkd1urq1v",
  );

  static String? _cloudImage;

  // ---- Pick image from gallery
  imagePicker(BuildContext context, bool isCamera) async {
    try {
       log("image not picked");
      XFile? image = await ImagePicker().pickImage(
        source:isCamera? ImageSource.camera:ImageSource.gallery,
      );
      log("image picked");
      if (image == null) {
        return "assets/no_user.jpg";
      }

      final pickedImage = File(image.path);
      _cloudImage = await cloudinaryImage(pickedImage);

      return _cloudImage;
    } on PlatformException {
      return SnackBarWidget.flushbar(
          context: context, message: "image picker failed");
    }
  }

  Future<String?> cloudinaryImage(File file) async {
    final response = await cloudinary.upload(
      file: file.path,
      fileBytes: file.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
    );
    if (response.isSuccessful) {
      return response.secureUrl;
    }
    return null;
  }
}
