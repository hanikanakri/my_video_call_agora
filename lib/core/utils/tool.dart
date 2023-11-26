import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_colors.dart';
import '../widgets/dialog/util_dialog.dart';
import '../widgets/upload_image_widget.dart';

class Tool {
  static void displayModalBottomSheet({
    context,
    ValueChanged<UploadImageModel?>? onSuccess,
    int? refType = 2,
  }) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return ContentBottomSheet(
            onSuccess: onSuccess,
            refType: refType,
          );
        });
  }

  static buildImage(
      {ImageSource? source,
      required BuildContext context,
      ValueChanged<XFile?>? onSuccess}) async {
    // Step #1: Pick an image
    await ImagePicker().pickImage(source: source!).then((pickedFile) async {
      // Step #2: Check if we actually picked an image. Otherwise -> stop;

      if (pickedFile == null) return;
      if (Platform.isWindows) {
        onSuccess!(XFile(pickedFile.path));
        return;
      }

      // Step #3: Crop earlier selected image

      await cropSelectedImage(pickedFile.path).then((croppedFile) {
        // Step #4: Check if we actually cropped an image. Otherwise -> stop;
        if (croppedFile == null) return;

        if (isValidImage(XFile(croppedFile.path), context)) {
          // Step #4: Check if we actually cropped an image. Otherwise -> stop;
          if (croppedFile == null) return;
          if (isValidImage(XFile(croppedFile.path), context)) {
            // Step #5: if the image is valid save the changes and close screen
            //  Navigator.pop(context);
            onSuccess!(XFile(croppedFile.path));
            return;
          }
        }
      });
    });
  }

  static Future<File?> cropSelectedImage(String filePath) async {
    return await ImageCropper().cropImage(
      sourcePath: filePath,
      // aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'edit_photo'.tr(),
          toolbarColor: AppColors.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original),
      iosUiSettings: IOSUiSettings(
        title: 'edit_photo'.tr(),
        aspectRatioLockEnabled: true,
        minimumAspectRatio: 1.0,
        aspectRatioPickerButtonHidden: true,
      ),
    );
  }

  static bool isValidImage(XFile? image, BuildContext context) {
    List validFormat = ['png', 'jpg', 'JPG', 'jpeg', 'JPEG'];
    if (validFormat.contains(image!.name.split('.').last)) {
      return true;
    } else {
      UtilDialog.showInformation(context,
          content: 'invalid_format'.tr(), title: 'error'.tr());
      return false;
    }
  }
}
class UploadImageModel  {
  int? id;
  String? url;
  XFile? file;

  UploadImageModel({
    this.id,
    this.url,
    this.file,
  });


}