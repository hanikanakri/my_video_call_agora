import '../constants/app_colors.dart';
import '../utils/custom_easy_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class EasyLoadingClass{

  static  getStyleEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = AppColors.primaryColor
      ..backgroundColor = AppColors.white
      ..indicatorColor = AppColors.white
      ..textColor = AppColors.primaryColor
      ..maskColor = AppColors.primaryColor.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
      ..indicatorWidget = const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 2,
        ),
      )
      ..infoWidget = const Icon(Icons.info_outline, color: AppColors.primaryColor,size: 25,)
      ..errorWidget = const Icon(Icons.close, color: AppColors.primaryColor,size: 25)
      ..successWidget = const Icon(Icons.done, color: AppColors.primaryColor,size: 25)
      ..customAnimation = CustomAnimation();

  }
}