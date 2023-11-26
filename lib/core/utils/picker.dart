import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Picker {
  static Future pick({FileType type = FileType.any}) async {
    FilePickerResult? filePickerResult;
    try {
      filePickerResult = await FilePicker.platform.pickFiles(type: type
          // allowedExtensions: ['jpg', 'png'],
          );
    } on PlatformException catch (e) {
      debugPrint("Unsupported operation$e");
    }

    if (filePickerResult != null) {
      try {
        debugPrint('done');
        return File(filePickerResult.files.single.path!);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  static Future pickListImage() async {
    FilePickerResult? filePickerResult;
    try {
      filePickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      );

      if (filePickerResult != null) {
        debugPrint('done');
        List<File> files =
            filePickerResult.files.map((path) => File(path.path!)).toList();
        return files;
      } else {
        debugPrint('cancel');
      }
    } on PlatformException catch (e) {
      debugPrint("Unsupported operation$e");
    }
  }
}
