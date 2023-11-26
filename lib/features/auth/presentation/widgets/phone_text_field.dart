// import 'package:furniture_moving_app/core/constants/app_theme.dart';
// import 'package:furniture_moving_app/core/utils/shared_storage.dart';
// import 'package:intl_phone_field/countries.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/phone_number.dart';

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';


import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/shared_storage.dart';

class PhoneTextField extends StatefulWidget {
  final ValueChanged<PhoneNumber>? onChanged;
  final ValueChanged<Country>? onCountryChange;
  final TextEditingController? phoneController;
  final String? initialCountryCode;
  final TextInputType? keyboardType;
  final bool isEdit;
  VoidCallback? editPhoneNumber;

  PhoneTextField({
    super.key,
    this.onChanged,
    this.editPhoneNumber,
    this.onCountryChange,
    this.phoneController,
    this.initialCountryCode,
    this.keyboardType,
    this.isEdit = false,
  });

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: IntlPhoneField(
        readOnly: widget.isEdit ? true : false,
        keyboardType: widget.keyboardType!,
        controller: widget.phoneController,
        decoration: AppTheme.inputDecoration.copyWith(
            suffixIcon: Visibility(
              visible: widget.isEdit,
              child: InkWell(
                onTap: widget.editPhoneNumber,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    '',
                  ),
                ),
              ),
            ),
            //contentPadding: EdgeInsets.symmetric(horizontal: 100),
            // prefixIcon: Padding(padding:EdgeInsets.all(5) ),
            disabledBorder: AppStyles.inputDecorationBorder.copyWith(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                  style: BorderStyle.solid,
                  width: 0.3,
                  color: AppColors.transparent),
            ),
            border: AppStyles.inputDecorationBorder.copyWith(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                  style: BorderStyle.solid,
                  width: 0.3,
                  color: AppColors.transparent),
            ),
            enabledBorder: AppStyles.inputDecorationBorder.copyWith(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                  style: BorderStyle.solid,
                  width: 0.4,
                  color: AppColors.transparent),
            ),
            focusedBorder: AppStyles.inputDecorationBorder.copyWith(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                  style: BorderStyle.solid,
                  width: 0.4,
                  color: AppColors.transparent),
            ),
            fillColor: AppColors.lightGrey),
        showDropdownIcon: true,
        showCountryFlag: true,
        showCursor: false,
        languageCode: SharedStorage.getLanguage(),
        dropdownIconPosition: IconPosition.leading,
        initialCountryCode:
        widget.initialCountryCode != null
            ? widget.initialCountryCode != "+963"
            ? "AE"
            : "SY"
            : "AE",

        onCountryChanged: widget.onCountryChange!,

        onChanged: widget.onChanged,
      ),
    );
  }}