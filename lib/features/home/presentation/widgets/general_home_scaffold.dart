// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_video_call_agora/features/home/presentation/widgets/drop_down_widget.dart';

import '../../../../core/constants/app_colors.dart';


import '../../../../core/constants/app_theme.dart';
import '../../../auth/presentation/widgets/general_background_image.dart';

class GeneralHomeScaffold extends StatelessWidget {
  GeneralHomeScaffold({super.key, this.body,});

  Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.transparent,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title:  Text("hani_app".tr(),style: AppTheme.headline.copyWith(color: AppColors.white,fontSize: 18),),
        actions: [
          DropDownWidget(
            firstText: "logout_account",
            outSideColor: AppColors.transparent,
            secondText: "edit_account",
          ),
        ],
      ),
      body:Stack(
        children: [
          GeneralBackgroundImage(),
          body ?? const SizedBox(),
        ],
      ),
    );
  }
}
