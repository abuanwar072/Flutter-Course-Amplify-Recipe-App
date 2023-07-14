import 'package:amplify_recipe/features/authentication/widgets/forgot_password_form.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/constants/gaps.dart';
import '../../../themes/app_colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.text,
                    ),
              ),
              gapH16,
              const Text(
                'Enter your email address and we will send you a reset instructions.',
              ),
              gapH24,
              const ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}
