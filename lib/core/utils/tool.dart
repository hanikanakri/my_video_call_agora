import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/dialog/util_dialog.dart';
import '../widgets/upload_image_widget.dart';

class Tool {
  static Future autoCopy(String copyText)async{
    FlutterClipboard.copy(copyText).then(( value ) =>
        print(copyText));
  }

  static Future<String> autoPast()async{
    String pastText = await FlutterClipboard.paste();
   return pastText;
  }




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

      await cropSelectedImage(pickedFile.path,context).then((croppedFile) {
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

  static Future<CroppedFile?> cropSelectedImage(String filePath,BuildContext context) async {
    return  await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
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