import 'package:amplify_recipe/features/authentication/screens/register_screen.dart';
import 'package:amplify_recipe/features/authentication/screens/sign_in_screen.dart';
import 'package:amplify_recipe/features/common/data/cognito_authentication_repository.dart';
import 'package:amplify_recipe/main.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/constants/gaps.dart';
import '../../entry_point.dart';

class OnboardContent extends StatefulWidget {
  const OnboardContent({
    super.key,
  });

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}

class _OnboardContentState extends State<OnboardContent> {
  late Future<bool> futureOperation;

  @override
  void initState() {
    futureOperation =
        getIt.get<CognitoAuthenticationRepository>().isUserLogedIn();
    super.initState();
  }

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
            FutureBuilder(
              future: futureOperation,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EntryPoint(),
                      ),
                    );
                  });
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: snapshot.hasData
                      ? const RegisterAndLoginButton()
                      : const SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterAndLoginButton extends StatelessWidget {
  const RegisterAndLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.transparent),
          ),
          child: const Text("Sign in"),
        ),
      ],
    );
  }
}
