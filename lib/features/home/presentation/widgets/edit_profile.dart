// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_video_call_agora/core/database/db/sqflite.dart';
import 'package:my_video_call_agora/core/widgets/buttons/main_elevated_button.dart';
import 'package:my_video_call_agora/core/widgets/custom_text_field.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/navigation.dart';

import '../../../auth/presentation/widgets/phone_text_field.dart';
import '../pages/home_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController? editEmailController;

  TextEditingController? editPhoneController;

  TextEditingController? editNameController;

  SqfliteDataBase sqfliteDataBase = SqfliteDataBase();

  List<Map> snapshotData = [];
  bool isLoading = true;

  Future readData() async {
    List<Map> response =
        await sqfliteDataBase.readDatabase("SELECT * FROM tasks");

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
    return response;
  }

  Future<void> _fetchData() async {
    List<Map> response = await readData();
    setState(() {
      snapshotData = response;
      editEmailController =
          TextEditingController(text: "${snapshotData[0]['emailAddress'] ?? ''}");
      editPhoneController =
          TextEditingController(text: "${snapshotData[0]['phoneNumber'] ?? ''}");
      editNameController =
          TextEditingController(text: "${snapshotData[0]['fullName'] ?? ''}");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();/*.then((value) {

    })*/
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.white,
          ),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...[
                      PhoneTextField(
                        phoneController: editPhoneController,
                        keyboardType: TextInputType.phone,
                        onCountryChange: (value) {},
                        initialCountryCode: "+963",
                      ),
                      CustomTextField(
                        hintText: 'edit_name',
                        controller: editNameController,
                      ),
                      CustomTextField(
                        hintText: 'edit_email',
                        controller: editEmailController,
                      ),
                      MainElevatedButton(
                        onPressed: () async {
                          updateDataBase().then((value) {
                            print('ggggggggggggggggggggggggggggggg');
                            Navigation.pushReplacement(context, const HomeScreen());
                          });
                        },
                        text: 'change',
                      ),
                    ].expand(
                      (element) => [
                        element,
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  updateDataBase() async {
    await sqfliteDataBase.updateDatabase('''
                    UPDATE tasks SET 
                    fullName     = "${editNameController!.text}" ,
                    emailAddress = "${editEmailController!.text}" ,
                    phoneNumber  = "${editPhoneController!.text}"
                    WHERE id = 1
                    ''');
    setState(() {});
  }
}
