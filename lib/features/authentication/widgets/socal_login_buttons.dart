// ignore_for_file: unused_import

import 'package:amplify_recipe/shared/data/authentication_repository.dart';
import 'package:amplify_recipe/features/entry_point.dart';
import 'package:amplify_recipe/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/constants/gaps.dart';

class SocalLoginButtons extends StatelessWidget {
  const SocalLoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 1.5),
              child: Text('or continue with'),
            ),
            Expanded(
              child: Divider(),
            ),
          ],
        ),
        gapH16,
        OutlinedButton.icon(
          onPressed: () {
            getIt.get<AuthenticationRepository>().logInWithGoogle().then(
              (value) {
                context.go('/entry-point');
              },
            ).onError((error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.toString()),
                ),
              );
            });
          },
          icon: SvgPicture.asset('assets/icons/Google.svg'),
          label: const Text('Sign Up with Google'),
        ),
        gapH16,
        OutlinedButton.icon(
          onPressed: () {
            getIt.get<AuthenticationRepository>().logInWithFacebook().then(
              (value) {
                context.go('/entry-point');
              },
            ).onError((error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.toString()),
                ),
              );
            });
          },
          icon: SvgPicture.asset('assets/icons/Faceboook.svg'),
          label: const Text('Sign Up with Facebook'),
        ),
      ],
    );
  }
}
