// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_video_call_agora/core/constants/app_theme.dart';
import 'package:my_video_call_agora/core/utils/validators.dart';
import 'package:my_video_call_agora/core/widgets/buttons/main_elevated_button.dart';
import 'package:my_video_call_agora/features/auth/presentation/pages/your_info.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../data/register_info.dart';
import '../widgets/general_auth_border.dart';
import '../widgets/general_auth_scaffold.dart';
import '../widgets/phone_text_field.dart';

class ContinueRegisterPage extends StatefulWidget {
  ContinueRegisterPage({
    super.key,
    this.registerInfo,
  });

  RegisterInfo? registerInfo;

  @override
  State<ContinueRegisterPage> createState() => _ContinueRegisterPageState();
}

class _ContinueRegisterPageState extends State<ContinueRegisterPage> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController tokenController = TextEditingController();

  GlobalKey<FormState> continueRegisterPageKey = GlobalKey<FormState>();

  FocusNode? nameFocusNode;
  FocusNode? passwordFocusNode;
  FocusNode? confirmPasswordFocusNode;
  FocusNode? tokenFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    tokenFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralAuthScaffold(
      body: Form(
        key: continueRegisterPageKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'complete_your_information'.tr(),
              style: AppTheme.headline.copyWith(
                color: AppColors.white,
              ),
            ),
            GeneralAuthBorder(
              isVertical: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...[
                    PhoneTextField(
                      phoneController: phoneController,
                      keyboardType: TextInputType.phone,
                      onCountryChange: (value) {},
                      initialCountryCode: "+963",
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      focusNode: nameFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      hintText: 'inter_your_full_name',
                      controller: fullNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) => Validator.nameValidate(
                        fullNameController.text,
                        context,
                      ),
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      focusNode: passwordFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      hintText: 'inter_your_password',
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) => Validator.passwordValidate(
                        passwordController.text,
                        context,
                      ),
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      focusNode: confirmPasswordFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(tokenFocusNode),
                      hintText: 'inter_your_confirm_password',
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                      validator: (value) => Validator.confirmPasswordValidate(
                        passwordController.text,
                        confirmPasswordController.text,
                        context,
                      ),
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.done,
                      focusNode: tokenFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      hintText: 'inter_your_other_device_token',
                      controller: tokenController,
                      validator: (value) => Validator.emptyValue(
                        tokenController.text,
                        context,
                      ),
                    ),
                  ].expand(
                    (element) => [
                      element,
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            MainElevatedButton(
              onPressed: () {
                if (continueRegisterPageKey.currentState!.validate()) {
                  widget.registerInfo?.fullName = fullNameController.text;
                  widget.registerInfo?.confirmPassword =
                      confirmPasswordController.text;
                  widget.registerInfo?.token = tokenController.text;
                  widget.registerInfo?.phoneNumber =
                      int.tryParse(phoneController.text);
                  Navigation.push(
                    context,
                    YourInfo(
                      registerInfo: widget.registerInfo,
                    ),
                  );
                }
              },
              text: "continue",
            ),
          ],
        ),
      ),
    );
  }
}
