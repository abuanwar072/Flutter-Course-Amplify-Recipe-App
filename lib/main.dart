// ignore_for_file: unused_import

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_push_notifications_pinpoint/amplify_push_notifications_pinpoint.dart';
import 'package:amplify_recipe/features/authentication/screens/onboarding_screen.dart';
import 'package:amplify_recipe/features/common/data/amplify_recipe_repository.dart';
import 'package:amplify_recipe/features/common/data/authentication_repository.dart';
import 'package:amplify_recipe/features/common/data/cognito_authentication_repository.dart';
import 'package:amplify_recipe/features/common/data/local_search_repository.dart';
import 'package:amplify_recipe/features/common/data/notification_repository.dart';
import 'package:amplify_recipe/features/common/data/pinpoint_notification_repository.dart';
import 'package:amplify_recipe/features/common/data/recipe_repository.dart';
import 'package:amplify_recipe/features/common/data/search_repository.dart';
import 'package:amplify_recipe/models/ModelProvider.dart';
import 'package:amplify_recipe/shared/navigation/routes.dart';
import 'package:amplify_recipe/themes/app_theme.dart';
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
  getIt.registerSingleton<NotificationRepository>(
    PinpointNotificationRepository(),
  );
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyAPI(modelProvider: ModelProvider.instance),
      AmplifyPushNotificationsPinpoint(),
    ]);
    await Amplify.configure(amplifyconfig);
    await handlePermissions();
  } on AmplifyException catch (e) {
    safePrint(
        'Something wrong with the Amplify configuration. Check this error: $e');
  }
}

Future<void> handlePermissions() async {
  final status = await Amplify.Notifications.Push.getPermissionStatus();
  if (status == PushNotificationPermissionStatus.granted) {
    // no further action is required, user has already granted permissions
    return;
  }
  if (status == PushNotificationPermissionStatus.denied) {
    // further attempts to request permissions will no longer do anything
    return;
  }
  if (status == PushNotificationPermissionStatus.shouldRequest) {
    // go ahead and request permissions from the user
    await Amplify.Notifications.Push.requestPermissions();
  }
  if (status == PushNotificationPermissionStatus.shouldExplainThenRequest) {
    // then request permissions
    await Amplify.Notifications.Push.requestPermissions();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AWS Amplify Recipe App',
      theme: AppTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
    );
  }
}
