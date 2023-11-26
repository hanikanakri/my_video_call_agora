import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_video_call_agora/core/utils/shared_storage.dart';

import '../constants/constant.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final GestureTapCallback? onSeeAllTap;

  const SectionTitle({Key? key, required this.title, this.onSeeAllTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //
          Text(
            title,
            style: AppTheme.headline6.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (onSeeAllTap != null)
            InkWell(
              onTap: onSeeAllTap,
              child: Text('see_all'.tr(),
                  style:  TextStyle(
                      fontFamily: SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
                      color: AppColors.primaryColor,
                      decoration: TextDecoration.underline)),
            )
        ],
      ),
    );
  }
}
