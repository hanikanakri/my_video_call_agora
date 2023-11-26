import 'dart:math';

import 'package:flutter/material.dart';


class AppColors {
  AppColors._();

  static const Map<int, Color> primarySwatch = {
    50: Color(0xFFE4ECF4),
    100: Color(0xFFBBCEE3),
    150: Color(0xFF4297C8),
    200: Color(0xFF8DAED0),
    250: Color(0xFF2867AD),
    300: Color(0xFF5F8EBD),
    400: Color(0xFF3D75AF),
    500: Color(0xFF1b5da1),
    600: Color(0xFF185599),
    700: Color(0xFF144B8F),
    800: Color(0xFF104185),
    900: Color(0xFF083074),
    1000: Color(0xFF0E3692),
  };


  static const textHeadLineColor = Color.fromRGBO(13, 13, 38, 1);
  static const grey60 = Color.fromRGBO(149, 150, 157, 1);
  static const grey4 = Color.fromRGBO(189, 189, 189, 1);

//  static const primaryColor = Color.fromRGBO(26, 51, 76, 1);
 // static const primaryColor = Color.fromRGBO(20, 108, 148, 1);
  static const primaryColor = Color(0xFF0073E9);
  static const mainGrayColor = Color(0xFFF4F6F8);
  static const blueLightColor = Color(0xFFb9dcf0);
  static const bodyTextColor = Color(0xFF747474);
  static const tagsTextColor = Color(0xFFAEAEAE);

//  MaterialColor(0xFF083074, primarySwatch);
  static const darkBlueColor = Color.fromRGBO(26, 51, 76, 1);
  static const primaryGrey = Color.fromRGBO(202, 203, 206, 1);

//  MaterialColor(0xFF4297C8, primarySwatch);
  static const blueColor = MaterialColor(0xFF2867AD, primarySwatch);

  static const Map<int, Color> secondaryMaterial = {
    1: Color(0xFFFCF4F1),
    5: Color(0xFFFDF4EC),
    10: Color(0xFFFCF2E6),
    25: Color(0xFFFCEAC5),
    50: Color(0xFFFCD38A),
    100: Color(0xFFFCC954),
    200: Color(0xFFFFC947),
    300: Color(0xFFFFC947),
    400: Color(0xFFFFC947),
    500: Color(0xFFFFC947),
    600: Color(0xFFE0A818),
    700: Color(0xFFC48E0A),
    800: Color(0xFF9A6C00),
    900: Color(0xFF503904),
  };

  static const secondaryColor = MaterialColor(0xFFFFC947, secondaryMaterial);

  static const white = Colors.white;
  static const offWhite = Color(0xFFF5F5F5);
  static const black = Colors.black;
  static const transparent = Colors.transparent;
  static Color grey = Colors.grey.shade500;


  static Color greyApp = const Color.fromRGBO(175, 192, 195, 1);
  static Color greyTest = const Color.fromRGBO(139, 139, 139, 1);
  static const lightGrey = Color(0xFFEEEFF0);
  static const darkGrey = Color(0xFFBCBDBD);
  static const midGrey = Color(0xFFD9D9D9);
  static const green = Color.fromRGBO(69, 200, 66, 1);
  static const orange = Color(0xFFFFAA00);
  static const primaryGreen = Color(0xFF7BC361);
  static const amber = Colors.amber;
  static const teal =  Colors.teal;

  static const red = Colors.red;
  static const  authColor= LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFB9DCF0), Color(0xFFE9F0F4)],
  );

  static Color getRandomColor() {
    return Color.fromRGBO(Random().nextInt(300), Random().nextInt(300),
        Random().nextInt(300), 0.5);
  }


  static Color whiteReviewCard = const Color(0xFFF8F8F8);
  static Color dividerGrayReviewCard = const Color(0xFFAEAEAE);
  static Color linearGrayReviewCard = const Color(0xFFEEEEEE);
}
