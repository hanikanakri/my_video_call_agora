// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';

class ShowInfo extends StatelessWidget {
  ShowInfo({
    super.key,
    this.title,
    this.subTitle,
  });

  String? title;
  String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text.rich(
        TextSpan(
          text: title?.tr(),
          style: AppTheme.headline.copyWith(
            color: AppColors.white,
          ),
          children: [
            const WidgetSpan(
              child: SizedBox(width: double.infinity,),
            ),
            TextSpan(
              text: subTitle?.tr(),
              style: AppTheme.bodySmall.copyWith(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
