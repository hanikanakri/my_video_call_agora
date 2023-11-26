import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/app_assets.dart';
import '../custom_image.dart';
import 'base_error_widget.dart';

class EmptyDataWidget extends StatelessWidget {
  final String? message;

  const EmptyDataWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseErrorWidget(
        onTap: () {},
        title: message ?? 'result_not_found'.tr(),
        subtitle: ''.tr(),
        icon: CustomImage.rectangle(
          image: AppAssets.noData,
          isNetworkImage: false,
           svg: false,
        )
    );
  }
}
