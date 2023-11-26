import 'package:flutter/material.dart';

import 'animated_drop_down.dart';

class DropDownListTile extends StatelessWidget {
  const DropDownListTile({
    Key? key,
    required this.child,
    required this.title,
    this.padding = EdgeInsets.zero,
    this.onTap,
    this.activeDecoration,
    this.active = false,
    this.duration = const Duration(milliseconds: 250),
    this.activeTitle,
  }) : super(key: key);
  final Widget child;
  final Widget title;
  final Decoration? activeDecoration;
  final Widget? activeTitle;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  final Duration duration;
  final bool active;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        active ? activeTitle ?? title : title,
        AnimatedDropDown(
          switched: active,
          duration: duration,
          reverseDuration: duration,
          child: child,
        ),
      ],
    );
  }
}
