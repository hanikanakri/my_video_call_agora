import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../constants/constant.dart';
import 'extensions.dart';

const double iconSize = 15.0;

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color color;
  final IconData icon;

  const CustomButton({
    Key? key,
    this.onPressed,
    this.title = 'press',
    this.color = AppColors.primaryColor,
    this.icon = AppIcons.circle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(
        title.tr(),
        style: AppTheme.button,
      ),
      icon: Icon(
        icon,
        color: Colors.indigoAccent.withOpacity(0.7), // TODO to edit
        size: iconSize,
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(150, 50),
          maximumSize: const Size(150, 50),
          shape: AppStyles.roundedRectangleBorder),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color color;
  final double? minWidth;
  final String tooltip;

  const CustomIconButton(
      {Key? key,
      this.onPressed,
      this.icon = AppIcons.circle,
      this.color = Colors.grey,
      this.minWidth,
      this.tooltip = 'press'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            width: minWidth ?? 40.0,
            height: minWidth ?? 40.0,
            decoration: AppStyles.iconBoxDecoration.copyWith(color: color),
            child: IconButton(
              icon: Icon(
                icon,
                color: color == AppColors.grey
                    ? Colors.indigoAccent.withOpacity(0.7) // TODO to edit
                    : AppColors.white.withOpacity(0.7),
                size: iconSize,
              ),
              onPressed: onPressed,
              tooltip: tooltip.tr(),
            ))
        .addNeumorphism(
      bottomShadowColor: color.withOpacity(0.4),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? color;
  final Color? titleColor;
  final Size minimumSize;
  final Size maximumSize;

  const CustomTextButton({
    Key? key,
    this.onPressed,
    this.title = 'press',
    this.color,
    this.minimumSize = const Size(150, 50),
    this.maximumSize = const Size(150, 50),
    this.titleColor = AppColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
//        primary: color??AppColors.primaryColor,
        backgroundColor: color ?? AppColors.primaryColor,
        minimumSize: minimumSize,
        maximumSize: maximumSize,
        shape: AppStyles.roundedRectangleBorder,
      ),
      onPressed: onPressed,
      child: Text(
        title.tr(),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color == AppColors.grey
                ? AppColors.primaryColor
                : titleColor), // TODO to edit
      ),
    );
  }
}
