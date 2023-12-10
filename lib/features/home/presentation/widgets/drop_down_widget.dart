import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/shared_storage.dart';
import 'package:my_video_call_agora/core/database/db/sqflite.dart';
import 'edit_profile.dart';

class DropDownWidget extends StatefulWidget {
  DropDownWidget({
    super.key,
    this.insideColor = AppColors.white,
    this.outSideColor = AppColors.primaryColor,
    required this.firstText,
    required this.secondText,
  });

  late Color insideColor;
  late Color outSideColor;
  String firstText;
  String secondText;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 67,
      height: 35,
      decoration: BoxDecoration(
        color: widget.outSideColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: PopupMenuButton<String>(
        // initialValue:"ar",
        color: widget.insideColor,

        itemBuilder: (BuildContext context) => [
          PopupMenuItem<String>(
            value: "firstText",
            child: ListTile(
              title: Text(
                widget.firstText.tr(),
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: "secondText",
            child: ListTile(
              title: Text(
                widget.secondText.tr(),
              ),
            ),
          )
        ],
        onSelected: (value) {
          if (value == 'firstText') {
            deleteDatabaseAndLogout().then((value) {
              Phoenix.rebirth(context);
              SharedStorage.removeToken();
            });
          } else {
            _editProfile(context);
          }
        },
      ),
    );
  }

  SqfliteDataBase sqfliteDataBase = SqfliteDataBase();

  Future<void> deleteDatabaseAndLogout() async {
    await sqfliteDataBase.deleteAllDatabase();
    setState(() {});
  }

  _editProfile(BuildContext context){
   showDialog(context: context, builder:  (context) {
     return const EditProfile();
   },);
  }
}
