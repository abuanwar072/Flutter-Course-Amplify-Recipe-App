import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/features/authentication/screens/onboarding_screen.dart';
import 'package:amplify_recipe/features/common/data/amplify_recipe_repository.dart';
import 'package:amplify_recipe/features/common/data/authentication_repository.dart';
import 'package:amplify_recipe/features/common/data/cognito_authentication_repository.dart';
import 'package:amplify_recipe/features/common/data/local_search_repository.dart';
import 'package:amplify_recipe/features/common/data/recipe_repository.dart';
import 'package:amplify_recipe/features/common/data/search_repository.dart';
import 'package:amplify_recipe/models/ModelProvider.dart';
import 'package:amplify_recipe/thems/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'amplifyconfiguration.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  _registerData();
  runApp(const MyApp());
}

void _registerData() {
  getIt.registerSingleton<AuthenticationRepository>(
    CognitoAuthenticationRepository(),
  );
  getIt.registerSingleton<RecipeRepository>(
    AmplifyRecipeRepository(),
  );
  getIt.registerSingleton<SearchRepository>(
    LocalSearchRepository(),
  );
}

Future<void> _configureAmplify() async {
  try {
    Amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyAPI(modelProvider: ModelProvider.instance),
    ]);
    await Amplify.configure(amplifyconfig);
  } on AmplifyException catch (e) {
    safePrint(
        "Something wrong with the Amplify configuration. Check this error: $e");
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
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
    );
  }
}
