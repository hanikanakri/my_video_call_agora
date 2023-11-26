import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_theme.dart';

class TextSwitch extends StatefulWidget {
  final bool? isFirstSelected;
  final VoidCallback? onPressFirst;
  final VoidCallback? onPressSecond;
  final String? firstText;
  final String? secondText;

  const TextSwitch(
      {Key? key,
      this.isFirstSelected = true,
      this.firstText  ,
      this.secondText ,
      required this.onPressFirst,
      required this.onPressSecond})
      : super(key: key);

  @override
  State<TextSwitch> createState() => _TextSwitchState();
}

class _TextSwitchState extends State<TextSwitch> {
  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainGrayColor,
        borderRadius: BorderRadius.circular(25),
        // border: Border.all(
        //   color: AppColors.mainGrayColor,
        // ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: widget.onPressFirst,
            child: Material(
              elevation: widget.isFirstSelected! ? 5 : 0,
              borderRadius: BorderRadius.circular(25),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: widget.isFirstSelected! ? screenWidth/2 : screenWidth/3,
                height: 50,
                curve: Curves.easeInCirc,
                decoration: BoxDecoration(
                  color: widget.isFirstSelected!
                      ? AppColors.primaryColor
                      : AppColors.mainGrayColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    widget.firstText??"",
                    style:  AppTheme.headline6.copyWith(
                      fontWeight: FontWeight.w500,
                      color:
                      widget.isFirstSelected! ? AppColors.white : AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: widget.onPressSecond,
            child: Material(
              elevation: widget.isFirstSelected! ? 0 : 5,
              borderRadius: BorderRadius.circular(25),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: widget.isFirstSelected! ? screenWidth/3 : screenWidth/2,
                height: 50,
                curve: Curves.easeInCirc,
                decoration: BoxDecoration(
                  color: widget.isFirstSelected!
                      ? AppColors.mainGrayColor
                      : AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    widget.secondText??"",
                    style: AppTheme.headline6.copyWith(
                      fontWeight: FontWeight.w500,
                      color:
                      widget.isFirstSelected! ? AppColors.black : AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
