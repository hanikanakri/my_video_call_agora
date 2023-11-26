import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../constants/constant.dart';

class ReadMoreWidget extends StatelessWidget {
  final String? text;
final Color? color;
  const ReadMoreWidget({Key? key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text??"",
      textAlign: TextAlign.justify,
      style: AppTheme.bodyText3.copyWith(color: color??AppColors.black),
      colorClickableText: AppColors.primaryColor,
      trimMode: TrimMode.Length,
      trimLines: 5,
      trimCollapsedText: 'show_more'.tr(),
      trimExpandedText: 'show_less'.tr(),
      moreStyle: AppTheme.bodyText2.copyWith(color: AppColors.grey),
      lessStyle: AppTheme.bodyText2.copyWith(color: AppColors.grey),
    );
  }
}
