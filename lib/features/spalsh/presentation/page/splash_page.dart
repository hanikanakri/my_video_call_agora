import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_settings.dart';
import '../../../../core/constants/app_theme.dart';

class Splash extends StatelessWidget {
  final dynamic navigator;

  const Splash({
    Key? key,
    this.navigator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      backgroundImage: const AssetImage(AppAssets.splashBackGroundImageURI),
      //backgroundColor: AppColors.primaryColor,
      logoWidth: 120,
      logo: Image.asset(
        AppAssets.splashLogo,
        //height: 200,
        alignment: Alignment.bottomCenter,
      ),
      // title: const Text(
      //   "MOVERS&",
      //   style: TextStyle(
      //       color: AppColors.white,
      //       fontSize: 15,
      //       letterSpacing: 2,
      //       fontWeight: FontWeight.bold),
      //   textDirection: TextDirection.ltr,
      // ),
      showLoader: true,
      loaderColor: AppColors.primaryColor,
      loadingText: Text(
        AppSettings.appVersion,
        style: AppTheme.headline6.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
//      navigator: navigator,
      futureNavigator: futureCall(context),
    );
  }

  Future<Widget> futureCall(context) async {
    return Future.delayed(const Duration(seconds: 4), () {
      print("SharedStorage.getLanguage()");
//      print(SharedStorage.getLanguage());
//      SettingRepository.changeLanguage(SharedStorage.getLanguage());
      return navigator;
    });
  }
}
