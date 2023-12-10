import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_video_call_agora/core/widgets/buttons/main_elevated_button.dart';
import 'package:my_video_call_agora/features/auth/presentation/widgets/pin_code_widegt.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/utils/validators.dart';
import '../../data/register_info.dart';
import '../widgets/general_auth_border.dart';
import '../widgets/general_auth_scaffold.dart';
import 'continue_register_page.dart';

class VerificationAuth extends StatefulWidget {
  const VerificationAuth({
    super.key,
    this.registerInfo,
  });

  final RegisterInfo? registerInfo;

  @override
  State<VerificationAuth> createState() => _VerificationAuthState();
}

class _VerificationAuthState extends State<VerificationAuth> {
  final TextEditingController? verificationController = TextEditingController();

  GlobalKey<FormState> verificationKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GeneralAuthScaffold(
      body: Form(
        key: verificationKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GeneralAuthBorder(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "enter_the_code_you_get_from_sms_or_email".tr(),
                    style: AppTheme.headline.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  PinCode(
                    verificationController: verificationController,
                    validator: (value) => Validator.emptyValue(
                      verificationController!.text,
                      context,
                    ),
                  ),
                ],
              ),
            ),
            MainElevatedButton(
              onPressed: () {
                if (verificationKey.currentState!.validate()) {
                  widget.registerInfo?.verificationCode =
                      int.tryParse(verificationController!.text);
                  Navigation.pushReplacement(
                    context,
                    ContinueRegisterPage(
                      registerInfo: widget.registerInfo,
                    ),
                  );
                }
              },
              text: 'continue',
            ),
          ],
        ),
      ),
    );
  }
}
