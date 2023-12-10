import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_video_call_agora/core/animations/navigation_route_animation/navigation_route_animation.dart';
import 'package:my_video_call_agora/core/widgets/custom_text_field.dart';
import 'package:my_video_call_agora/features/auth/presentation/pages/verification_auth.dart';
import 'package:my_video_call_agora/features/auth/presentation/widgets/general_auth_scaffold.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/buttons/main_elevated_button.dart';
import '../../data/register_info.dart';
import '../widgets/general_auth_border.dart';

class Register extends StatelessWidget {
  Register({
    super.key,
  });

  final RegisterInfo? registerInfo = RegisterInfo();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GeneralAuthScaffold(
      isBack: false,
      body: Center(
        child: Form(
          key: registerKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GeneralAuthBorder(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome_to_hani_app'.tr(),
                      style: AppTheme.headline.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 25,
                      ),
                      child: CustomTextField(
                        hintText: 'enter_your_email'.tr(),
                        hintColor: Colors.black,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => Validator.emailValidator(
                            emailController.text, context),
                      ),
                    ),
                  ],
                ),
              ),
              MainElevatedButton(
                text: 'continue',
                onPressed: () {
                  if (registerKey.currentState!.validate()) {
                    registerInfo?.emailAddress = emailController.text;
                    print(registerInfo!.emailAddress);
                    AnimationNavigation.slidePush(
                      context,
                      VerificationAuth(
                        registerInfo: registerInfo,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
