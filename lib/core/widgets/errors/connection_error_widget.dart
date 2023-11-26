import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import '../../constants/app_assets.dart';

import 'base_error_widget.dart';

class ConnectionErrorWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? message;

  const ConnectionErrorWidget({Key? key, this.onTap, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseErrorWidget(
        onTap: onTap,
        title: message,
        subtitle: 'tap_to_retry'.tr(),
//        icon: const Text('Must be Image')
        icon: Image.asset(AppAssets.errorData,height: 150,)
    );
  }
}
