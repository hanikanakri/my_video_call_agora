import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


import '../constants/app_colors.dart';
import '../constants/app_settings.dart';
import '../utils/shared_storage.dart';

class CustomCheckBox extends StatefulWidget {
  bool? value;
  final String? title;
  final Widget? widgetTitle;
  final ValueChanged<bool?>? onChanged;
  final bool isRequired;

  CustomCheckBox(
      {Key? key,
      this.title,
      this.onChanged,
      this.value = false,
      this.widgetTitle,
      this.isRequired = false})
      : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          checkboxTheme: CheckboxThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
      child: CheckboxListTile(
        subtitle: (!widget.value! && widget.isRequired)
            ? Text(
                'Required'.tr(),
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: SharedStorage.getLanguage() == "ar"
                      ? AppSettings.arabicFont
                      : AppSettings.englishFont,
                ),
              )
            : null,
        activeColor: AppColors.primaryColor,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        title: widget.title != null ? Text(widget.title!) : widget.widgetTitle,
        value: widget.value!,
        onChanged: (value) {
          setState(() {
            widget.value = value ?? false;
          });
          widget.onChanged!(value);
        },
      ),
    );
  }
}
