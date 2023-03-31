import 'package:amplify_recipe/features/authentication/screens/forgot_password_screen.dart';
import 'package:amplify_recipe/features/authentication/widgets/sign_in_form.dart';
import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/thems/app_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/socal_login_btns.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                "Welcome",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.text,
                    ),
              ),
              gapH16,
              const Text("Enter your email address for sign in"),
              gapH24,
              const SignInForm(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen()),
                    );
                  },
                  child: Text(
                    "Forgot password?",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              gapH16,
              const SocalLoginBtns()
            ],
          ),
        ),
      ),
    );
  }
}
