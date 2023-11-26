import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_theme.dart';
import 'custom_image.dart';


class CustomCardDetails extends StatelessWidget {
  final String? keys;
  final String? value;
  final String? image;
  final bool? isDark;
  final Color? textColor;
  final double? heightIcon;

  const CustomCardDetails({
    Key? key,
    this.keys,
    this.value,
    this.image,
    this.isDark = true,
    this.textColor,
    this.heightIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
//      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark!
                  ? [AppColors.primaryColor, AppColors.primaryColor]
                  : [

                      AppColors.primaryColor,
                      AppColors.primaryColor

                    ]),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: CustomImage.rectangle(
              image: image,
              isNetworkImage: false,
              svg: true,
              fit: BoxFit.contain,
              height: heightIcon,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...[
                  Text(keys!,
                      style: AppTheme.headline4.copyWith(color: textColor)),
                  Text(value!,
                      style: AppTheme.headline4.copyWith(color: textColor)),
                ].expand((element) => [
                      element,
                      const SizedBox(
                        height: 4,
                      )
                    ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCardDetailsNew extends StatelessWidget {
  final String? keys;
  final String? value;
  final String? image;
  final bool? isDark;
  final Color? textColor;
  final Color? cardColor;
  final double? heightIcon;

  const CustomCardDetailsNew({
    Key? key,
    this.keys,
    this.value,
    this.image,
    this.isDark = true,
    this.textColor,
    this.heightIcon, this.cardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
//      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
          image: const DecorationImage(
              image: AssetImage(AppAssets.appBackgroundURI),
              fit: BoxFit.fill),
          boxShadow: const [
            BoxShadow(
              color: AppColors.darkGrey,
              blurRadius: 2.0,
              offset: Offset(0, 2),
            ),
          ],
//          gradient: LinearGradient(
//              begin: Alignment.topCenter,
//              end: Alignment.bottomCenter,
//              colors: isDark!
//                  ? [AppColors.primaryColor, AppColors.primaryColor.shade500]
//                  : [
//                      AppColors.lightBlueColor,
//                      AppColors.lightBlueColor.shade300
//                    ]),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CircleAvatar(
                backgroundColor: AppColors.transparent,
              radius: 30,
              child: Image.asset(
                image ?? AppAssets.noData,
                height: 40,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...[
                Text(keys!,
                    style: AppTheme.headline4.copyWith(color: textColor)),
                Text(value!,
                    style: AppTheme.headline4.copyWith(color: textColor)),
              ].expand((element) => [
                    element,
                    const SizedBox(
                      height: 4,
                    )
                  ])
            ],
          ),
        ],
      ),
    );
  }
}

class DeterministicCard extends StatelessWidget {
  final String? keys;
  final String? value;
  final String? image;
  final Color? color;
  final Color? textColor;
  final bool? isDark;
  final bool? isSvg;

  const DeterministicCard(
      {Key? key,
      this.keys,
      this.value,
      this.image,
      this.color,
      this.textColor,
      this.isDark = false,
      this.isSvg = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.48,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.darkGrey),
          gradient: RadialGradient(radius: 5, colors: [
            color ?? AppColors.white,
            AppColors.lightGrey,
          ]),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          )),
      child: Container(
        alignment: Alignment.center,
        child: ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark!
                        ? [
                            AppColors.primaryColor,
                            AppColors.primaryColor
                          ]
                        : [

                            AppColors.primaryColor,
                            AppColors.primaryColor

                          ])),
//            child: Image.asset(image!),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomImage.rectangle(
                image: image!,
                isNetworkImage: false,
                svg: isSvg,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(keys!,
                  style: AppTheme.bodyText1.copyWith(
                      fontSize: 11, color: textColor ?? AppColors.primaryColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(
                height: 4,
              ),
              Text(value!,
                  style: AppTheme.bodyText1.copyWith(
                      fontWeight: FontWeight.w900,
                      color: textColor ?? AppColors.primaryColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
