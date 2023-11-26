import 'package:flutter/material.dart';

class WrapBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final WrapCrossAlignment wrapCrossAxisAlignment;
  final int itemCount;
  final Axis axis;

  const WrapBuilder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.wrapCrossAxisAlignment = WrapCrossAlignment.center,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: axis,
      children: List.generate(
        itemCount,
        (index) => itemBuilder(context, index),
      ).toList(),
    );
  }
}
