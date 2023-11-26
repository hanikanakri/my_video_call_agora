import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_video_call_agora/core/constants/app_assets.dart';
import 'package:my_video_call_agora/core/constants/app_colors.dart';
import 'package:my_video_call_agora/core/constants/app_constants.dart';
import 'package:my_video_call_agora/core/constants/app_theme.dart';

import '../utils/navigation.dart';
import '../utils/shared_storage.dart';

class LanguagesPopUpMenu extends StatefulWidget {
  Locale locale;
  late Color insideColor;
  late Color outSideColor;
  late bool withRebirth;

  LanguagesPopUpMenu(
      {required this.locale,
      this.insideColor = AppColors.white,
      this.outSideColor = AppColors.primaryColor,
      this.withRebirth = false,
      Key? key})
      : super(key: key);

  @override
  State<LanguagesPopUpMenu> createState() => _LanguagesPopUpMenuState();
}

class _LanguagesPopUpMenuState extends State<LanguagesPopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 67,
      height: 35,
      decoration: BoxDecoration(
        color: widget.outSideColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: PopupMenuButton<String>(
        // initialValue:"ar",
        color: widget.insideColor,
        icon: Row(
          children: [
            SvgPicture.asset(
              AppAssets.changeLanguageURI,
              width: 10,
              height: 10
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'en',style: AppTheme.bodyText2.copyWith(
              color: Colors.white,
            ),
            ).tr(),
          ],
        ),

//      Icon(
//        Icons.more_vert,
//        color: widget.color,
//        size: 25,
//      ),

        itemBuilder: (BuildContext context) => [
          PopupMenuItem<String>(
            value: "ar",
            child: ListTile(
              title: Text('arabic'.tr()),
//            leading: const Icon(
//              Icons.language,
//              size: 20,
//            ),
            ),
          ),
          PopupMenuItem<String>(
            value: "en",
            child: ListTile(
              title: Text(
                'english'.tr(),
              ),
//            leading: const Icon(
//            Icons.language,
//            size: 20,
//          ),
            ),
          )
//          PopupMenuItem(
//              child: PopupMenuButton(
//                child: ListTile(
//                  title: Text('language'.tr()),
//                  leading: const Icon(
//                    Icons.language,
//                    size: 25,
//                  ),
//                ),
//                itemBuilder: (BuildContext context) =>
//                [
//
//                ],
//
//              ))
        ],
        onSelected: (String value) {
          if (widget.locale.languageCode != value) {
            setState(() {
              debugPrint("widget.locale.languageCode");
              debugPrint(widget.locale.languageCode);
              debugPrint(value);
              SharedStorage.writeLanguage(value);
              context.setLocale(AppConstant.languages[value]!);
              Navigation.pop(context);
              widget.withRebirth ? Phoenix.rebirth(context) : null;
            });
          }
        },
      ),
    );
  }
}
