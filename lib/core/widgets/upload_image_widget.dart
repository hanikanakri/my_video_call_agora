import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_theme.dart';
import '../utils/navigation.dart';
import '../utils/tool.dart';

class ButtonUploadImage extends StatefulWidget {
  final ValueChanged<UploadImageModel?>? image;
  int? refType;

  ButtonUploadImage({
    super.key,
    this.image,
    this.refType,
  });

  @override
  _ButtonUploadImageState createState() => _ButtonUploadImageState();
}

class _ButtonUploadImageState extends State<ButtonUploadImage> {
  UploadImageModel imageModel = UploadImageModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 50,
//      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          Tool.displayModalBottomSheet(
              onSuccess: (image) {
                setState(() {

                });
                ///todo delete set state
                widget.image!(image!);
                Navigation.pop(context);

              },
              context: context);
        },
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: SvgPicture.asset(
            AppAssets.uploadImageIcon,
            width: 10,
            height: 10,
          ),
        ),
      ),
    );
  }
}

// class UploadImageWidget extends StatefulWidget {
//   final ValueChanged<UploadImageModel?>? image;
//
//   const UploadImageWidget({
//     super.key,
//     this.image,
//   });
//
//   @override
//   _UploadImageWidgetState createState() => _UploadImageWidgetState();
// }
//
// class _UploadImageWidgetState extends State<UploadImageWidget> {
//   UploadImageModel imageModel = UploadImageModel();
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomDottedBorder(
//       widget: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ...[
//             Text(
//               "title_upload_image".tr(),
//               textAlign: TextAlign.center,
//               style: AppTheme.bodyText1.copyWith(color: AppColors.grey),
//             ),
//             CardUploadImage(
//               title: "camera".tr(),
//               image: AppAssets.cameraIcon,
//               onSuccess: (value) {
//                 setState(() {
//                   widget.image!(value);
//                 });
//               },
//               source: ImageSource.camera,
//             ),
//             CardUploadImage(
//               title: "gallery".tr(),
//               image: AppAssets.galleryIcon,
//               onSuccess: (value) {
//                 setState(() {
//                   widget.image!(value);
//                 });
//               },
//               source: ImageSource.gallery,
//             )
//           ].expand((element) => [
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 element
//               ])
//         ],
//       ),
//       sizeHeight: 350,
//       sizeWidth: 250,
//       paddingDottedBorderOne:
//           const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//       marginWidget: const EdgeInsets.all(0),
//       paddingWidget: const EdgeInsets.all(0),
//       isShadow: false,
//     );
//   }
// }
//

class ContentBottomSheet extends StatefulWidget {
  final ValueChanged<UploadImageModel?>? onSuccess;
  int? refType;

  ContentBottomSheet({super.key, 
    this.onSuccess,
    this.refType,
  });

  @override
  _ContentBottomSheetState createState() => _ContentBottomSheetState();
}

class _ContentBottomSheetState extends State<ContentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 64),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 1),

          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 1),
                  Text(
                    'upload_your_photos'.tr(),
                    style: AppTheme.headline.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(

                        decoration: BoxDecoration(border: Border.all(color: AppColors.red) ,borderRadius: BorderRadius.circular(25)),

                        child: const Icon(
                          Icons.close,
                          color: AppColors.red,
                          size: 20,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 16),
              Padding(padding:const EdgeInsets.symmetric(horizontal: 16),
                child: Text('clarify_your_location_using_photo'.tr(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppTheme.headline.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
          /*Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardUploadImage(
                  refType: widget.refType,
                  title: "camera".tr(),
                  image: AppAssets.cameraIcon,
                  onSuccess: (value) {
                    setState(() {
                      widget.onSuccess!(value);
                    });
                  },
                  source: ImageSource.camera,
                ),
                CardUploadImage(
                  refType: widget.refType,
                  title: "gallery".tr(),
                  image: AppAssets.galleryIcon,
                  onSuccess: (value) {
                    setState(() {
                      widget.onSuccess!(value);
                    });
                  },
                  source: ImageSource.gallery,
                )
              ],
            ),
          ),*/
          const SizedBox(height: 1)
        ],
      ),
    );
  }
}

/*
class CardUploadImage extends StatefulWidget {
  final String? image;
  final String? title;
  final ImageSource? source;
  final ValueChanged<UploadImageModel?>? onSuccess;
  int? refType;

  CardUploadImage({
    super.key,
    this.image,
    this.title,
    this.source,
    this.onSuccess,
    this.refType,
  });

  @override
  _CardUploadImageState createState() => _CardUploadImageState();
}

class _CardUploadImageState extends State<CardUploadImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _customButton(),
        const SizedBox(
          height: 4,
        ),
        Text(widget.title!,
            style: AppTheme.bodyText1.copyWith(color: AppColors.grey)),
      ],
    );
  }

  final UploadImageModel _imageModel = UploadImageModel();
  CreateModelCubit? customCubit;

  UploadAttachmentRequest request = UploadAttachmentRequest();

  _customButton() {
    return CreateModel<UploadAttachmentResponse>(
      onCubitCreated: (cubit) {
        customCubit = cubit;
      },
      repositoryCallBack: (data) {
        return RequestRepository.uploadAttachment(data);
      },
      onSuccess: (UploadAttachmentResponse model) {
        setState(() {
          _imageModel.id = model.id;
          _imageModel.url = model.url;
          widget.onSuccess!(_imageModel);
        });
//        Navigation.pop(context, value: model.id);
      },
      child: InkWell(
        onTap: () {
          Tool.buildImage(
            context: context,
            onSuccess: (image) {
              setState(() {
                _imageModel.file = image;
                request.file = image!.path;
                request.refType = widget.refType;
              });
              customCubit?.createModel(request);
            },
            source: widget.source,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 23),
          decoration: BoxDecoration(
              color: AppColors.offWhite,
              borderRadius: BorderRadius.circular(8)),
          //height: double.infinity,
          width: 140,
          child: SvgPicture.asset(
            widget.image!,
            // height: 10,
            // width: 10,
          ),
        ),
      ),
    );
  }
}
*/
