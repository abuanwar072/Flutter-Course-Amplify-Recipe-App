import 'package:amplify_recipe/features/authentication/screens/register_screen.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/constants/gaps.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Cooking with \ngreat experiences",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            gapH16,
            const SizedBox(
              width: 250,
              child: Text(
                "The best experience is given based on the ingredients you have at home",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFADADAD)),
              ),
            ),
            gapH24,
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text("Register"),
            ),
            gapH8,
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.transparent),
              ),
              child: const Text("Sign in"),
            ),
          ],
        ),
      ),
    );
  }
}
