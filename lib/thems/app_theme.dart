import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: Colors.white,
    );
  }
}
