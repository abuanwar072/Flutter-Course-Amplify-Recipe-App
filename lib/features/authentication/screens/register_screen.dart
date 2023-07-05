import 'package:amplify_recipe/features/authentication/screens/sign_in_screen.dart';
import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/thems/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/sign_up_form.dart';
import '../widgets/socal_login_buttons.dart';
import '../widgets/terms_and_policy.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.text,
                    ),
              ),
              gapH16,
              Text.rich(
                TextSpan(
                  text: 'Enter your name, email and password for sign up. ',
                  children: [
                    TextSpan(
                      text: 'Already have an account?',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        },
                      style: const TextStyle(
                        color: AppColors.primary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              gapH24,
              const SignUpForm(),
              gapH20,
              const TermsAndPolicy(),
              gapH16,
              const SocalLoginButtons()
            ],
          ),
        ),
      ),
    );
  }
}
