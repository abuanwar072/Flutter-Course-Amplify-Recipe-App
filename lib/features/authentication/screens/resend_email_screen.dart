import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/constants/gaps.dart';
import '../../../themes/app_colors.dart';

class EmailResendScreen extends StatelessWidget {
  const EmailResendScreen({super.key});

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
                'Email Sent',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.text,
                    ),
              ),
              gapH16,
              Text.rich(
                TextSpan(
                  text: 'Not receiving email? check on promotion page, spam. ',
                  children: [
                    TextSpan(
                      text: 'Having problem?',
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      style: const TextStyle(
                        color: AppColors.primary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              gapH24,
              ElevatedButton(
                onPressed: () {},
                child: const Text('Resend'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
