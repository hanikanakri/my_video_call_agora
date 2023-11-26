import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../constants/constant.dart';
import 'custom_image.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final IconData? icon;
  final String? imageData;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final bool? general;
  final bool? required;
  final bool? enabled;
  final bool? readOnly;
  final bool isSVG;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final GestureTapCallback? onTap;
  final InputDecoration? inputDecoration;
  final Widget? suffix;
  final Widget? prefix;
  final FocusNode? focusNode;
  final Color? hintColor;
  final void Function()? onEditingComplete;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintColor,
    this.onEditingComplete,
    this.focusNode,
    required this.hintText,
    this.icon,
    this.imageData,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.autofocus = false,
    this.controller,
    this.general = false,
    this.required = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.onTap,
    this.inputDecoration,
    this.suffix,
    this.isSVG = true,
    this.prefix,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isSeen = false;
  late InputDecoration _inputDecoration;

  @override
  void initState() {
    super.initState();
    if (widget.inputDecoration == null) {
      _inputDecoration =
//      !widget.general! ?
          AppTheme.inputDecoration.copyWith(
        iconColor: AppColors.grey,
        disabledBorder: AppStyles.inputDecorationBorder.copyWith(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            width: 0.3,
            color: AppColors.lightGrey,
          ),
        ),
        border: AppStyles.inputDecorationBorder.copyWith(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            width: 0.3,
            color: AppColors.lightGrey,
          ),
        ),
        focusedBorder: AppStyles.inputDecorationBorder.copyWith(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            width: 0.4,
            color: AppColors.transparent,
          ),
        ),
        enabledBorder: AppStyles.inputDecorationBorder.copyWith(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            width: 0.4,
            color: AppColors.transparent,
          ),
        ),
        counterText: "",
        suffixIcon: widget.suffix,
        prefix: widget.prefix,
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: AppColors.lightGrey,
                size: 20,
              )
            : widget.imageData != null
                ? Padding(
                    padding: const EdgeInsets.all(14.5),
                    child: CustomImage.rectangle(
                      image: widget.imageData,
                      isNetworkImage: false,
                      svg: widget.isSVG,
                      height: 5,
                      fit: BoxFit.contain,
                    ),
                  )
                : null,
        fillColor: AppColors.mainGrayColor,
      );
    } else {
      _inputDecoration = widget.inputDecoration!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.labelText != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Text(
                  widget.labelText!,
                  style: AppTheme.bodyText1.copyWith(color: AppColors.black),
                ),
              )
            : Container(
                padding: EdgeInsets.zero,
              ),
        widget.labelText != null
            ? const SizedBox(
                height: 4,
              )
            : Container(padding: EdgeInsets.zero),
        TextFormField(
          inputFormatters: widget.keyboardType == TextInputType.name
              ? <TextInputFormatter>[UpperCaseTextFormatter()]
              : null,
          readOnly: widget.readOnly!,
          enabled: widget.enabled!,
          focusNode: widget.focusNode,
          onEditingComplete: widget.onEditingComplete,
          onTap: widget.onTap,
          expands: widget.maxLength == 0 ? true : false,
          controller: widget.controller,
          decoration: _inputDecoration.copyWith(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              hintText:
                  !widget.required! ? widget.hintText.tr() : '${widget.hintText.tr()} *',
              hintStyle: AppTheme.subtitle2.copyWith(
                fontWeight: FontWeight.w300,
                color: widget.hintColor ?? AppColors.grey,
              ),
              suffixIcon: widget.obscureText!
                  ? PlatformIconButton(
                      onPressed: () {
                        setState(() {
                          isSeen = !isSeen;
                        });
                      },
                      icon: Icon(
                          isSeen
                              ? context.platformIcons.eyeSolid
                              : context.platformIcons.eyeSlashSolid,
                          size: 15),
                    )
                  : null),
          validator: widget.validator,
          obscureText: !isSeen ? widget.obscureText! : false,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          autofocus: widget.autofocus!,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
        ),
      ],
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}


