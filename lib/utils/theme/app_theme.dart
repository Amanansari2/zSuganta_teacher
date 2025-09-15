import 'package:flutter/material.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/theme/custom_themes/app_bar_theme.dart';
import 'package:z_tutor_suganta/utils/theme/custom_themes/text_filed_theme.dart';
import 'package:z_tutor_suganta/utils/theme/custom_themes/text_themes.dart';

import 'custom_themes/chip_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orange),
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    textTheme: AppTextTheme.lightTextTheme,
    inputDecorationTheme: AppTextFormFiledTheme.lightInputDecorationTheme,
    chipTheme: MyChipTheme.lightChipTheme
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue,),
    appBarTheme: MyAppBarTheme.darkAppBarTheme,
    textTheme: AppTextTheme.darkTextTheme,
    inputDecorationTheme: AppTextFormFiledTheme.darkInputDecorationTheme,
    chipTheme: MyChipTheme.darkChipTheme
  );
}