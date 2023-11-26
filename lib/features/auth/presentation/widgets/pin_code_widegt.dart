import 'dart:async';




import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_settings.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/shared_storage.dart';

class PinCode extends StatefulWidget {
  PinCode({
    super.key,
    this.currentText,
    this.errorAnimationController,
    this.verificationController,
    this.validator,
  });

  StreamController<ErrorAnimationType>? errorAnimationController;

  TextEditingController? verificationController;
  String? currentText;
  String? Function(String?)? validator;

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 25,
        ),
        child: PinCodeTextField(
          appContext: context,
          validator: widget.validator,
          length: 6,
          obscureText: false,
          keyboardType: TextInputType.phone,
          animationType: AnimationType.slide,
          textStyle: AppTheme.headline,

          pastedTextStyle: TextStyle(
            fontFamily: SharedStorage.getLanguage() == "ar"
                ? AppSettings.arabicFont
                : AppSettings.englishFont,
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.bold,
          ),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.circle,
            fieldHeight: 40,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.greyApp,
            disabledColor: AppColors.transparent,
            inactiveFillColor: AppColors.whiteReviewCard,
           // borderRadius: BorderRadius.circular(25),
            /*disabledColor:*/
          ),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: AppColors.transparent,
          animationCurve: Curves.linear,
          enableActiveFill: true,
          errorAnimationController: widget.errorAnimationController,
          controller: widget.verificationController,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          onCompleted: (v) {
            print("Completed");
          },
          onChanged: (value) {
            print(value);
            setState(() {
              widget.currentText = value;
            });
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
      ),
    );
  }
}
