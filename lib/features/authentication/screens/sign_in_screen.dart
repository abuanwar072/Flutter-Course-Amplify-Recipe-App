import 'package:amplify_recipe/features/authentication/widgets/sign_in_form.dart';
import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/socal_login_buttons.dart';

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
                'Welcome',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.text,
                    ),
              ),
              gapH16,
              const Text('Enter your email address for sign in'),
              gapH24,
              const SignInForm(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    context.push('/forgot-password');
                  },
                  child: Text(
                    'Forgot password?',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              gapH16,
              const SocalLoginButtons()
            ],
          ),
        ),
      ),
    );
  }
}
