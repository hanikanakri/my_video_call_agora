import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_theme.dart';
import '../utils/shared_storage.dart';
import 'custom_image.dart';

class ImageTitleSubtitle extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? imageUrl;
  String? city;
  String? region;
  final Function? onPressButton;

  ImageTitleSubtitle(
      {Key? key,
      this.title,
      this.subTitle,
      this.imageUrl,
      this.city,
      this.region,
      this.onPressButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(55.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.height * .35,
                //padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                    bottomRight: Radius.elliptical(500, 340),
                    bottomLeft: Radius.elliptical(500, 340),
                  ),
                  gradient: AppColors.authColor,
                ),
                child: CustomImage.rectangle(
                  image: imageUrl!,
                  svg: false,
                  isNetworkImage: false,
                  fit: BoxFit.contain,
                  //height: sizes.maxHeight * 60 / 100,
                ),
              ),
              // SizedBox(
              //   height: sizes.maxHeight * 4 / 100,
              // ),

              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Text(
                  textAlign: TextAlign.start,
                  title!,
                  style: AppTheme.headline6.copyWith(
                    fontFamily: 'CustomIcons',
                    fontSize: 16,
                    color: AppColors.black,
                  ),

                  // style: AppTheme.flexHeadline2(
                  //   sizes.maxHeight * 7 / 100,
                  //   sizes.maxWidth,
                  // ).copyWith(
                  //   overflow: TextOverflow.ellipsis,
                  //   color: AppColors.black,
                  // ),
                ),
              ),
              // Expanded(
              //   child: SizedBox(
              //     height: sizes.maxHeight * 1 / 100,
              //   ),
              // ),
              // SizedBox(
              //   height: size.height*0.02,
              // ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Text(
                  subTitle!,
                  textAlign: TextAlign.start,
                  style: AppTheme.bodyText1.copyWith(
                    color: AppColors.grey60,
                    overflow: TextOverflow.fade,
                  ),
                  // style: AppTheme.flexBodyText2(
                  //   sizes.maxHeight * 24 / 100,
                  //   sizes.maxWidth - 80,
                  // ).copyWith(
                  //   color: AppColors.greyTest,
                  // ),
                ),
              ),
              // Expanded(
              //   child: SizedBox(height: sizes.maxHeight * 1 / 100),
              // ),
              // SizedBox(
              //   height: size.height*0.05,
              // ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                // width: isSmall!
                //     ? AppDimension.screenWidth(context) / 3
                //     : AppDimension.screenWidth(context) * 4 / 5,
                height: 45,
                alignment: SharedStorage.getLanguage() == "en"
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                child: FloatingActionButton(
                  onPressed: () => onPressButton!.call(),
                  backgroundColor: AppColors.primaryColor,
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),

              // MainElevatedButton(onPressed: () {  }, text: '',)
            ],
          ),
        ),
      ),
    );
  }
}
