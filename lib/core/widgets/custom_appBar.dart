import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_theme.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onSaveTemp;
  final bool? isVisible;

  const CustomAppBar({
    Key? key,
    this.title,
    this.onSaveTemp,
    this.isVisible = true,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      bottomOpacity: 0.0,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: AppColors.black, //change your color here
      ),
      actions: [
        onSaveTemp != null
            ? InkWell(
                onTap: onSaveTemp,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SvgPicture.asset(
                    AppAssets.saveTempIcon,
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            : Container()
      ],
      title: Text(
        title!.tr(),
        style: AppTheme.headline6.copyWith(color: AppColors.darkBlueColor),
      ),
      leading: Visibility(
        visible: isVisible!,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 16),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
