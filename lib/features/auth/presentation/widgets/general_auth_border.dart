// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GeneralAuthBorder extends StatelessWidget {
  GeneralAuthBorder({
    super.key,
    this.child,
    this.isVertical = false,
    this.isFull = false,
  });

  Widget? child;
  bool isVertical;
  bool isFull;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFull ? double.infinity : null,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      padding:
          EdgeInsets.symmetric(horizontal: 10, vertical: isVertical ? 15 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white),
      ),
      child: child,
    );
  }
}
