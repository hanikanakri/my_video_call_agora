import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../constants/constant.dart';
import '../utils/validators.dart';
import 'custom_text_field.dart';

class PopupTextField extends StatefulWidget {
  String? initialValue;
  late String valueText = '';
  final ValueChanged<String>? onChanged;
  final int? minLines;
  final String labelText;
  final bool? required;
  final bool? general;
  final IconData? icon;

  PopupTextField(
      {Key? key,
      required this.initialValue,
      this.onChanged,
      this.minLines = 1,
      required this.labelText,
      this.required = false,
      this.general = true,
      this.icon})
      : super(key: key);

  @override
  State<PopupTextField> createState() => _PopupTextFieldState();
}

class _PopupTextFieldState extends State<PopupTextField> {
  late final TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      icon: widget.icon,
      general: widget.general,
      required: widget.required,
      onTap: () async {
        _displayTextInputDialog(context);
      },
      controller: TextEditingController(text: widget.initialValue.toString()),
      labelText: widget.labelText,
      hintText: widget.labelText,
      validator: (value) => Validator.nameValidate(value!, context),
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLength: 1000,
      maxLines: 10,
      minLines: widget.minLines,
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16),
            insetPadding: const EdgeInsets.all(16),
            title: Text(widget.labelText),
            content: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              // height: 300,
              child: CustomTextField(
                controller: _textFieldController,
                labelText: '',
                hintText: '',
                onChanged: (value) {
                  setState(() {
                    widget.valueText = value;
                  });
                  widget.onChanged!(value);
                },
                validator: (value) => Validator.nameValidate(value!, context),
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                maxLines: 10,
                minLines: 9,
              ),
            ),
            actions: <Widget>[
              PlatformTextButton(
                color: AppColors.primaryColor,
                onPressed: () => setState(() {
                  widget.initialValue = widget.valueText;
                  Navigator.pop(context);
                }),
                child: Text(
                  'ok'.tr(),
                ),
              ),
            ],
          );
        });
  }
}
