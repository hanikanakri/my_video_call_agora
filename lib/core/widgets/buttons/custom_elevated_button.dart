import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CustomElevatedButton extends StatefulWidget {
  String? title;
  Color? primaryColor;
  EdgeInsets? padding;
  double? radius;
  Function()? onPressed;
  CustomElevatedButton({
    required this.title,
    this.primaryColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
    this.radius = 8.0,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return PlatformElevatedButton(
      onPressed: widget.onPressed,
      child: Text(
        widget.title!,
      ),
      material: (_, __) => MaterialElevatedButtonData(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.primaryColor,
          padding: widget.padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius!),
          ),
        ),
      ),
      cupertino: (_, __) => CupertinoElevatedButtonData(
        color: widget.primaryColor,
        padding: widget.padding,
        borderRadius: BorderRadius.circular(widget.radius!),
        pressedOpacity: 0.3,
      ),
    );
  }
}
