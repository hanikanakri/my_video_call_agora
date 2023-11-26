import 'package:flutter/material.dart';

class AnimateScroll {
   static void scrollToTop(
      {required ScrollController scrollController,
      int position = 0,
      Duration duration = const Duration(seconds: 1),
      Curve curve = Curves.linear}) {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }
}
