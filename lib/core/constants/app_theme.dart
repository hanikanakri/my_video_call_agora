import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_video_call_agora/core/utils/shared_storage.dart';

import 'constant.dart';

class AppTheme {
  AppTheme._();

  static const cardShadowColor = Color(0xFFd3d1d1);
  static const borderLine = Color(0xffc0c0c0);
  static const double iconSize = 20;
  static ThemeData get appTheme => ThemeData(
    iconTheme: const IconThemeData(color: AppColors.black, size: iconSize),
    primaryColor: AppColors.primaryColor,
    fontFamily: SharedStorage.getLanguage() == "ar"
        ? AppSettings.arabicFont
        : AppSettings.englishFont,
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: _inputDecorationTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
    cupertinoOverrideTheme: appThemeCupertino,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: AppColors.primaryColor,
          minimumSize: const Size(double.infinity, 44),
          textStyle: button),
    ),
    primarySwatch: Colors.green,
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryColor, shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      side: const BorderSide(color: AppColors.primaryColor, width: 1),
    )),
  );

  static CupertinoThemeData appThemeCupertino = CupertinoThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: CupertinoTextThemeData(
          textStyle: bodyText1,
          actionTextStyle: bodyText1,
          dateTimePickerTextStyle: bodyText1,
          navActionTextStyle: bodyText1,
          navLargeTitleTextStyle: bodyText1,
          navTitleTextStyle: bodyText1,
          pickerTextStyle: bodyText1,
          tabLabelTextStyle: bodyText1,
          primaryColor: AppColors.white)
      // textTheme: _textTheme,
      );

  static const _appBarTheme = AppBarTheme(
    color: AppColors.primaryColor,
    shadowColor: cardShadowColor,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: AppColors.white, size: iconSize),
    actionsIconTheme:
        IconThemeData(color: AppColors.primaryColor, size: iconSize),
    centerTitle: true,
  );

  static const _inputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.all(8),
    fillColor: Colors.transparent,
    filled: true,
    prefixIconColor: AppColors.primaryColor,
  );

  static final inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(4),
    fillColor: AppColors.lightGrey,
    filled: true,
    prefixIconColor: AppColors.grey,
    disabledBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(
          style: BorderStyle.solid, width: 0.3, color: AppColors.primaryColor),
    ),
    border: AppStyles.inputDecorationBorder.copyWith(

      borderSide: const BorderSide(
          style: BorderStyle.solid, width: 0.3, color: AppColors.primaryColor),
    ),
    enabledBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(
          style: BorderStyle.solid, width: 0.4, color: AppColors.primaryColor),
    ),
    focusedBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
    ),
    errorBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(color: Colors.red, width: 1),
    ),
    focusedErrorBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
    ),
  );

  static final _textTheme = TextTheme(
      bodyLarge: bodyText1,
      bodyMedium: bodyText2,
      labelLarge: button,
      titleMedium: subtitle1,
      titleSmall: subtitle2,
      headlineSmall: headline5,
      titleLarge: headline6);

  static TextStyle get bodyText1 => TextStyle(
      fontSize: 12,
      fontFamily: SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
      color: AppColors.primaryColor,);
  static TextStyle get bodyText2 => TextStyle(
      fontSize: 12,
      fontWeight:FontWeight.w600,
      fontFamily: SharedStorage.getLanguage() == "ar" ? AppSettings.arabicFont : AppSettings.englishFont);
  static TextStyle get bodyText3 => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
      color: AppColors.white,); // default for Text() widget
  static TextStyle get button => TextStyle(
      fontSize: 12,
      fontFamily: SharedStorage.getLanguage() == "ar" ? AppSettings.arabicFont : AppSettings.englishFont);
  static TextStyle get subtitle1 => TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      fontFamily: SharedStorage.getLanguage() == "ar"
          ? AppSettings.arabicFont
          : AppSettings.englishFont); // default for ListTile(title:) widget style
  static TextStyle get subtitle2 => TextStyle(
      fontSize: 11,
      fontFamily: SharedStorage.getLanguage() == "ar" ? AppSettings.arabicFont : AppSettings.englishFont);
  static TextStyle get headline4 => TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
      fontFamily: SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
      color: AppColors.white);
  static TextStyle get headline3 => TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      fontFamily: SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
      color: AppColors.primaryColor);
  static TextStyle get headline5 => TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
      fontFamily: SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
      color: AppColors.black);
  static TextStyle get  headline6 => TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontFamily: SharedStorage.getLanguage() == "ar" ? AppSettings.arabicFont : AppSettings.englishFont,
      color: AppColors.primaryColor);

//Flex Text
  static TextStyle _getFlexBodyText(double rate, double h, double w) {
    if (w < h) {
      return TextStyle(
        fontSize: w * rate,
        color: AppColors.white,
        fontFamily:
            SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
      );
    } else {
      return TextStyle(
        fontSize: h * rate,
        color: AppColors.white,
        fontFamily: SharedStorage.getLanguage() == "ar" ? AppSettings.arabicFont : AppSettings.englishFont,
      );
    }
  }

  static TextStyle _getFlexHeadLineText(double rate, double h, double w) {
    if (w < h) {
      return TextStyle(
          fontSize: w * rate,
          color: AppColors.white,
          fontFamily:
              SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
          fontWeight: FontWeight.bold,);
    } else {
      return TextStyle(
          fontSize: h * rate,
          color: AppColors.white,
          fontFamily:
              SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
          fontWeight: FontWeight.bold);
    }
  }

  static TextStyle get headline => TextStyle(
      fontFamily: SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.textHeadLineColor);

  static TextStyle get bodySmall => TextStyle(
    color: AppColors.grey60,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
  );

  static TextStyle flexHeadline2(double h, double w) =>
      _getFlexHeadLineText(0.8, h, w);

  static TextStyle flexBodyText2(double h, double w) =>
      _getFlexBodyText(0.15, h, w);
}
