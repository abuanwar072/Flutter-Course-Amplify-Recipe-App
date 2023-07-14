import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';

class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(text: 'By signing up, you agree to our ', children: [
        TextSpan(
          text: 'Terms of Service',
          recognizer: TapGestureRecognizer()..onTap = () {},
          style: const TextStyle(
            color: AppColors.primary,
            height: 1.5,
          ),
        ),
        const TextSpan(text: ' and '),
        TextSpan(
          text: 'Privacy Policy',
          recognizer: TapGestureRecognizer()..onTap = () {},
          style: const TextStyle(
            color: AppColors.primary,
            height: 1.5,
          ),
        ),
      ]),
    );
  }
}
