import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/features/authentication/screens/onboarding_screen.dart';
import 'package:amplify_recipe/features/common/data/cognito_authentication_repository.dart';
import 'package:amplify_recipe/thems/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerData();
  await _configureAmplify();
  runApp(const MyApp());
}

void _registerData() {
  getIt.registerSingleton<CognitoAuthenticationRepository>(
    CognitoAuthenticationRepository(),
  );
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyAPI(modelProvider: ModelProvider.instance),
    ]);
    await Amplify.configure(amplifyconfig);
  } on AmplifyException catch (e) {
    safePrint(
        'Something wrong with the Amplify configuration. Check this error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AWS Amplify Recipe App',
      theme: AppTheme.lightTheme(context),
      home: const OnboardingScreen(),
    );
  }
}
