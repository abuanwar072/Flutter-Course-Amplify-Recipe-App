import 'package:amplify_recipe/features/authentication/screens/onboarding_screen.dart';
import 'package:amplify_recipe/thems/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
