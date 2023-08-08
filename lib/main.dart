import 'package:amplify_recipe/shared/data/database/isar_provider.dart';
import 'package:amplify_recipe/shared/data/implementation/local_notification_repository.dart';
import 'package:amplify_recipe/shared/data/implementation/local_recipe_repository.dart';
import 'package:amplify_recipe/shared/data/implementation/local_search_repository.dart';
import 'package:amplify_recipe/shared/data/implementation/mock_authentication_repository.dart';
import 'package:amplify_recipe/shared/data/implementation/mock_storage_repository.dart';
import 'package:amplify_recipe/shared/data/notification_repository.dart';
import 'package:amplify_recipe/shared/data/storage_repository.dart';
import 'package:amplify_recipe/shared/data/authentication_repository.dart';
import 'package:amplify_recipe/shared/data/recipe_repository.dart';
import 'package:amplify_recipe/shared/data/search_repository.dart';
import 'package:amplify_recipe/shared/navigation/routes.dart';
import 'package:amplify_recipe/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _registerData();
  runApp(const MyApp());
}

Future<void> _registerData() async {
  await IsarProvider.open();
  getIt.registerSingleton<AuthenticationRepository>(
    MockAuthenticationRepository(),
  );
  getIt.registerSingleton<StorageRepository>(
    MockStorageRepository(),
  );
  getIt.registerSingleton<RecipeRepository>(
    LocalRecipeRepository(),
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
