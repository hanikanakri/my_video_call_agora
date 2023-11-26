import 'package:flutter/material.dart';

class AnimatedDropDown extends StatelessWidget {
  const AnimatedDropDown({
    Key? key,
    this.duration = const Duration(milliseconds: 500),
    this.reverseDuration = const Duration(milliseconds: 500),
    required this.switched,
    required this.child,
  }) : super(key: key);
  final bool switched;
  final Widget child;
  final Duration duration;
  final Duration reverseDuration;

  @override
  Widget build(BuildContext context) {
    Widget child = switched ? this.child : const SizedBox();
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: reverseDuration,
      child: child,
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: child,
        );
      },
    );
  }
}
