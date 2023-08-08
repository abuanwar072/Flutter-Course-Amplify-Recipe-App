import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/data/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/constants/gaps.dart';

class OnboardContent extends StatefulWidget {
  const OnboardContent({
    super.key,
  });

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}

class _OnboardContentState extends State<OnboardContent> {
  late final Future<bool> futureOperation;

  @override
  void initState() {
    super.initState();
    futureOperation = getIt.get<AuthenticationRepository>().isUserLoggedIn();
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
              'Cooking with \ngreat experiences',
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
                'The best experience is given based on the ingredients you have at home',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFADADAD)),
              ),
            ),
            gapH24,
            FutureBuilder<bool>(
              future: futureOperation,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go('/entry-point');
                  });
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: snapshot.data == false
                      ? Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.push('/register');
                              },
                              child: const Text('Register'),
                            ),
                            gapH8,
                            OutlinedButton(
                              onPressed: () {
                                context.push('/sign-in');
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              child: const Text('Sign in'),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
