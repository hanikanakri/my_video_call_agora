import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/app_assets.dart';
import 'base_error_widget.dart';

class NotFoundErrorWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final String message;

  const NotFoundErrorWidget(
      {Key? key, required this.onTap, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseErrorWidget(
        onTap: onTap,
        title: message,
        subtitle: 'Tap to retry'.tr(),
//        icon: const Text('Must be Image')
        icon: Image.asset(AppAssets.errorData, height: 150));
  }
}
