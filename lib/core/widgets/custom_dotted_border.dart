import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDottedBorder extends StatelessWidget {
  Widget? widget;
  Color? color;
  double? sizeHeight;
  double? sizeWidth;
  EdgeInsets? paddingDottedBorderOne;
  EdgeInsets? paddingWidget;
  EdgeInsets? marginWidget;
  bool? isShadow;

  CustomDottedBorder({
    Key? key,
    required this.widget,
    this.color = const Color.fromRGBO(171, 190, 248, 1),
    this.sizeHeight = 140,
    this.sizeWidth = 140,
    this.paddingDottedBorderOne =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.paddingWidget = const EdgeInsets.all(16),
    this.marginWidget = const EdgeInsets.all(8),
    this.isShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),

      ),
      child: Center(
        child: DottedBorder(
          strokeWidth: 0.6,
          borderType: BorderType.RRect,
          radius: const Radius.circular(8),
          dashPattern: const [12, 12],
          strokeCap: StrokeCap.round,
          color: color!,
          child: Container(
            margin: marginWidget!,
            padding: paddingWidget!,
            height: sizeHeight,
            width: sizeWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: isShadow!
                  ? [
                      BoxShadow(
                        color: color!,
                        blurRadius: 75,
                        // Shadow position
                      ),
                    ]
                  : null,
            ),
            child: widget!,
          ),
        ),
      ),
    );
  }
}
