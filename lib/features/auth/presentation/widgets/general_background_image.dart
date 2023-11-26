// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';

class GeneralBackgroundImage extends StatelessWidget {
  GeneralBackgroundImage({
    super.key,
    this.fit,
  });

  BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.homePageBackGroundImageURI,
      fit: fit ?? BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
