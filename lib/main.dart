import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_push_notifications_pinpoint/amplify_push_notifications_pinpoint.dart';
import 'package:amplify_recipe/amplifyconfiguration.dart';
import 'package:amplify_recipe/models/ModelProvider.dart';
import 'package:amplify_recipe/shared/data/database/isar_provider.dart';
import 'package:amplify_recipe/shared/data/implementation/local_notification_repository.dart';
import 'package:amplify_recipe/shared/data/implementation/local_remote_recipe_repository.dart';
import 'package:amplify_recipe/shared/data/implementation/local_search_repository.dart';
import 'package:amplify_recipe/shared/data/implementation/cognito_authentication_repository.dart';
import 'package:amplify_recipe/shared/data/implementation/s3_storage_repository.dart';
import 'package:amplify_recipe/shared/data/notification_repository.dart';
import 'package:amplify_recipe/shared/data/storage_repository.dart';
import 'package:amplify_recipe/shared/data/authentication_repository.dart';
import 'package:amplify_recipe/shared/data/recipe_repository.dart';
import 'package:amplify_recipe/shared/data/search_repository.dart';
import 'package:amplify_recipe/shared/navigation/routes.dart';
import 'package:amplify_recipe/themes/app_theme.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  await _registerData();
  await getIt.get<NotificationRepository>().handlePermissions();
  await getIt.get<NotificationRepository>().listenNotifications();
  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugins(
      [
        AmplifyAuthCognito(),
        AmplifyAPI(modelProvider: ModelProvider.instance),
        AmplifyStorageS3(),
        AmplifyPushNotificationsPinpoint(),
      ],
    );
    await Amplify.configure(amplifyconfig);
  } on AmplifyException catch (e) {
    safePrint(e);
  }
}

Future<void> _registerData() async {
  await IsarProvider.open();
  getIt.registerSingleton<AuthenticationRepository>(
    CognitoAuthenticationRepository(),
  );
  getIt.registerSingleton<StorageRepository>(
    S3StorageRepository(),
  );
  getIt.registerSingleton<RecipeRepository>(
    LocalRemoteRecipeRepository(),
  );
  getIt.registerSingleton<SearchRepository>(
    LocalSearchRepository(),
  );
  getIt.registerSingleton<NotificationRepository>(
    LocalNotificationRepository(),
  );
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
