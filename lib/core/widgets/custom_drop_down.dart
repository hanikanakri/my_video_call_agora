import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/validators.dart';

class CustomDropDown<T extends dynamic> extends StatefulWidget {
  final IconData? icon;
  final List<T> items;
  final String text;
  final ValueChanged<T> onChanged;
  T initialValue;
  final bool? general;
  final bool? required;
  bool? isEnabled;


  CustomDropDown({
    Key? key,
    required this.items,
    required this.text,
    required this.initialValue,
    required this.onChanged,
    this.icon,
    this.general = true,
    this.required = false,
    this.isEnabled=true,
  }) : super(key: key);

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T extends dynamic> extends State<CustomDropDown<T>> {
  late InputDecoration _inputDecoration;

  @override
  void initState() {
    super.initState();
    _inputDecoration = !widget.general!
        ? AppTheme.inputDecoration
        : InputDecoration(
      label: Row(
        children: [
          Text(widget.text),
          if (widget.required!)
            const Text(
              ' *',
              style: TextStyle(color: Colors.red),
            )
        ],
      ),
    );
  }

  Widget itemWidget(String text) {
    return Row(
      children: [
        Icon(widget.icon!, color: AppColors.primaryColor, size: 15),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      for (T element in widget.items) {
        if (element != null) {
          element.name;
          break;
        }
      }
    } on NoSuchMethodError {
      return const Text('First item not include name property');
    } on StateError {
      return const Text('Items is empty');
    } catch (e) {
      return Text(e.toString());
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      !widget.general!
          ? Text(widget.text,
          style: AppTheme.bodyText2.copyWith(color: AppColors.primaryColor))
          : Container(),
      DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<T>(
          decoration: _inputDecoration.copyWith(
            hintText: widget.text,
          ),
          validator: (value) =>
              Validator.nameValidate(value?.name.toString() ?? '', context),
          isExpanded: true,
          hint: !widget.general! ? itemWidget(widget.text) : null,
          items: widget.items
              .map(
                (item) => DropdownMenuItem<T>(
              value: item,
              child: !widget.general!
                  ? itemWidget(item.name.toString())
                  : Text(item.name.toString(), style: AppTheme.bodyText2),
            ),
          )
              .toList(),
          value: widget.initialValue,
          onChanged: !widget.isEnabled!?null:(value) {
            setState(() {
              widget.initialValue = value as T;
            });
            widget.onChanged(value as T);
          },
          icon: const Icon(
            Icons.arrow_drop_down_sharp,
          ),
          iconSize: 20,
          iconEnabledColor: AppColors.primaryColor,
          iconDisabledColor: Colors.white54,
          buttonPadding:
          EdgeInsets.symmetric(horizontal: !widget.general! ? 4 : 2),
          offset: const Offset(0, 5.5),
          dropdownDecoration: BoxDecoration(
            borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(10)),
            border: Border.all(
                style: BorderStyle.solid,
                color: AppColors.primaryColor,
                width: 0.4),
            color: Colors.white,
          ),
        ),
      )
    ]);
  }
}

class ObjectDropDownItem {
  final int id;
  final String name;

  ObjectDropDownItem({required this.id, required this.name,});

  @override
  String toString() {
    return name;
  }
}
