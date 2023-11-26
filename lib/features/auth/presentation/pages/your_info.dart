// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_video_call_agora/core/database/image_db/image_db.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/utils/shared_storage.dart';
import '../../../../core/widgets/buttons/main_elevated_button.dart';
import '../../../../core/widgets/dialog/util_dialog.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../data/register_info.dart';
import 'package:my_video_call_agora/core/database/db/sqflite.dart';
import '../widgets/general_auth_border.dart';
import '../widgets/general_auth_scaffold.dart';
import '../widgets/show_info.dart';

class YourInfo extends StatefulWidget {
  YourInfo({
    super.key,
    this.registerInfo,
  });

  RegisterInfo? registerInfo;

  @override
  State<YourInfo> createState() => _YourInfoState();
}

class _YourInfoState extends State<YourInfo> {
  SqfliteDataBase sqfliteDataBase = SqfliteDataBase();

/*  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseInfo.createDatabase();
  }*/

  @override
  Widget build(BuildContext context) {
    return GeneralAuthScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ImageStorage(),
          GeneralAuthBorder(
            isFull: true,
            child: Column(
              children: [
                ShowInfo(
                  title: 'full_name',
                  subTitle: widget.registerInfo!.fullName,
                ),
                ShowInfo(
                  title: "email",
                  subTitle: widget.registerInfo!.emailAddress,
                ),
                ShowInfo(
                  title: 'phone_number',
                  subTitle: "${widget.registerInfo!.phoneNumber}",
                ),
                ShowInfo(
                  title: 'token',
                  subTitle: widget.registerInfo!.token ??
                      'you have not inter token',
                ),
              ],
            ),
          ),
          MainElevatedButton(
            onPressed: () {
              UtilDialog.showAwesomeDialog(
                context: context,
                cancel: () {
                  Navigation.pop(context);
                },
                ok: () {
                  saveInfo(context);
                },
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Text(
                    'are_you_sure_of_your_info?'.tr(),
                    style: AppTheme.headline,
                  ),
                ),
              );
            },
            text: 'finish',
          ),
        ],
      ),
    );
  }

  saveInfo(context) async {
    /*await DatabaseInfo.insertToDatabase(
      taskes: widget.registerInfo!,
    );*/
    int response = await sqfliteDataBase.insertDatabase('''
    INSERT INTO tasks (`fullName`, `emailAddress`, `phoneNumber`)
    VALUES ("${widget.registerInfo!.fullName}", "${widget.registerInfo!.emailAddress}", "${widget.registerInfo!.phoneNumber}")
    ''');
    if (response > 0) {
      Navigation.pushAndRemoveUntil(context, const HomeScreen());
      SharedStorage.writeToken(widget.registerInfo!.token);
    }
    print(response);


  }
}
