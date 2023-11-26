import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_video_call_agora/core/constants/constant.dart';
import 'package:my_video_call_agora/features/auth/presentation/widgets/general_background_image.dart';

import '../../../../core/widgets/Languages_popUp.dart';

// ignore: must_be_immutable
class GeneralAuthScaffold extends StatelessWidget {
  GeneralAuthScaffold({
    super.key,
    this.body,
    this.isBack = true,
  });

  Widget? body;
  bool isBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        leading: Visibility(
            visible: isBack,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            )),
        title: Text(
          "Register_at_hani_app".tr(),
          style: AppTheme.headline.copyWith(
            color: AppColors.white,
          ),
        ),
        actions: [
          LanguagesPopUpMenu(
            locale: context.locale,
            outSideColor: AppColors.transparent,
            withRebirth: true,
          )
        ],
      ),
      body: Stack(
        children: [
          GeneralBackgroundImage(),
          body ?? const SizedBox(),
        ],
      ),
    );
  }
}
