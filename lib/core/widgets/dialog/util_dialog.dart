import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../custom_button.dart';
import '../loading.dart';

class UtilDialog {
  static showInformation(
    BuildContext context, {
    String? title,
    String? content,
    Function()? onClose,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? "message_for_you".tr(),
          ),
          content: Text(content!.tr()),
          actions: <Widget>[
            TextButton(
              onPressed: onClose ?? () => Navigator.of(context).pop(),
              child: Text(
                "close".tr(),
              ),
            )
          ],
        );
      },
    );
  }

  static showWaiting(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 150,
            alignment: Alignment.center,
            child: const LoadingWidget(),
          ),
        );
      },
    );
  }

  static hideWaiting(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<bool?> showConfirmation(BuildContext context,
      {String? title,
      required Widget content,
      String confirmButtonText = "yes",
      VoidCallback? confirmonPressed}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title == null ? "confirm" : title.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          content: content,
          actions: <Widget>[
            CustomTextButton(
              title: 'cancel'.tr(),
              onPressed: () => Navigator.pop(context, false),
            ),
            CustomTextButton(
                title: confirmButtonText,
                onPressed: () {
                  confirmonPressed!();
                  Navigator.pop(context, true);
                }),
          ],
        );
      },
    );
  }

  static showAwesomeDialog({
    context,
    Function()? ok,
    Function()? cancel,
    DialogType? dialogType,
    Widget? body,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType ?? DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      btnCancelOnPress: cancel,
      btnOkOnPress: ok,
      btnCancelText: "no".tr(),
      btnOkText: "yes".tr(),
      body: body,
    ).show();
  }

  showDiscardChangesAlert({
    context,
    VoidCallback? onPressedNo,
    VoidCallback? onPressedDiscard,
  }) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actionsPadding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
          title: Text('discard_changes'.tr(), style: AppTheme.headline6),
          content: Text('ask_to_discard_changes'.tr()),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: onPressedNo,
              child: Text('no_thanks'.tr()),
            ),
            TextButton(
              onPressed: onPressedDiscard,
              child: Text('discard'.tr()),
            ),
          ],
        );
      },
    );
  }
}
