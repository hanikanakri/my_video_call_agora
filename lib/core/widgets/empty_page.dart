import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import 'custom_image.dart';
import 'loading.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: CircleAvatar(
              radius: 120,
              backgroundColor: AppColors.primaryColor,
              child: CustomImage.rectangle(
                placeHolder: const LoadingWidget(),
                image: AppAssets.logoURI,
                isNetworkImage: false,
                svg: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
