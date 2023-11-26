import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_theme.dart';

class MainElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final bool? isSmall;
  final bool? withMargin;
  final double? height;
  final double? width;
  final double? radius;
  final TextStyle? textStyle;

  const MainElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textColor,
    this.buttonColor,
    this.withMargin = false,
    this.isSmall = false,
    this.height,
    this.width,
    this.textStyle,
    this.radius = 25.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: withMargin! ? 16 : 0, vertical: withMargin! ? 8 : 0),
      width: isSmall!
          ? MediaQuery.of(context).size.width/ 3
          : MediaQuery.of(context).size.width * 4 / 5,
      height: height ?? 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.all(Size(double.infinity, height ?? 45)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                //8.0
                radius!,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            buttonColor ?? AppColors.primaryColor,
          ),
        ),
        child: Text(
          text.tr(),
          textAlign: TextAlign.center,
          style: AppTheme.headline.copyWith(
            color: AppColors.white,
          ),
          /*TextStyle(
            fontFamily:
                SharedStorage.getLanguage() == "ar" ? "Tajawal" : "Outfit",
            fontSize: isSmall! ? 10 : 14,
            color: textColor ?? AppColors.white,
            fontWeight: FontWeight.w700,
          ),*/
        ),
      ),
    );
  }
}
