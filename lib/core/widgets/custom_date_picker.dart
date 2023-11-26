import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart' as intl;

import '../constants/constant.dart';
import '../utils/shared_storage.dart';
import '../utils/validators.dart';

class CustomDatePicker extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData? icon;
  final bool? autofocus;
  late DateTime? date;
  final ValueChanged<DateTime> onChanged;
  final bool? general;
  final bool? required;
  bool enable;
  DateTime? firstDate;
  DateTime? lastDate;

  CustomDatePicker(
      {Key? key,
      required this.date,
      required this.onChanged,
      required this.labelText,
      required this.hintText,
      this.icon,
      this.autofocus,
      this.general = true,
      this.required = false,
      this.firstDate,
      this.lastDate,
      this.enable = true})
      : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late InputDecoration _inputDecoration;

  @override
  void initState() {
    super.initState();
    _inputDecoration = !widget.general!
        ? AppTheme.inputDecoration.copyWith(
            prefixIcon: Icon(
              widget.icon,
              size: 15,
            ),
          )
        : InputDecoration(
            suffixIcon: Icon(
            widget.icon,
            size: 20,
          ));
  }

  dynamic newDate;

  @override
  Widget build(BuildContext context) {
    widget.firstDate =
        widget.firstDate == null ? DateTime(1900) : widget.firstDate!;
    widget.lastDate =
        widget.lastDate == null ? DateTime(2100) : widget.lastDate!;

    DateTime? lastDate = DateTime(2100);
    return TextFormField(
      enabled: widget.enable,
      readOnly: true,
      controller: TextEditingController(
          text: widget.enable
              ? widget.date == null
                  ? newDate == null
                      ? ''
                      : intl.DateFormat.yMd().format(newDate)
                  : intl.DateFormat.yMd().format(widget.date!)
              : ''),
      onTap: () async {
        newDate = await showPlatformDatePicker(
          context: context,
          initialDate: widget.date ?? DateTime.now(),
          firstDate: widget.firstDate!,
          lastDate: widget.lastDate!,
        );
        if (newDate == null) {
          return;
        }
        setState(() {
          widget.date = newDate;
        });
        widget.onChanged(newDate);
      },
      decoration: _inputDecoration.copyWith(
        hintText: newDate != null
            ? intl.DateFormat.yMd().format(newDate)
            : widget.hintText,
        label: Row(
          children: [
            Text(widget.labelText),
            if (widget.required!)
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontFamily:SharedStorage.getLanguage() == "ar" ?  AppSettings.arabicFont: AppSettings.englishFont,
                ),
              )
          ],
        ),
      ),
      validator: (value) => Validator.nameValidate(value!, context),
    );
  }
}
