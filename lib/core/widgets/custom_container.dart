import 'package:flutter/material.dart';

import '../constants/constant.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  BoxDecoration? decoration = AppStyles.defaultBoxDecoration.copyWith(boxShadow: AppStyles.defaultShadow);

  CustomContainer(
      {Key? key,
      this.height,
      this.padding = const EdgeInsets.all(8),
      this.margin,
      required this.child,
      this.width = double.infinity,
      this.decoration})
      : super(key: key) {
    decoration ??= AppStyles.defaultBoxDecoration.copyWith(boxShadow: AppStyles.defaultShadow);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      decoration: decoration,
      child: child,
    );
  }
}
