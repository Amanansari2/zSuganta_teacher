import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class MyAppBarTheme{
  MyAppBarTheme._();

  static  const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.black, size: 24),
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.black)
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme:  IconThemeData(color: AppColors.white, size: 24),
    actionsIconTheme: IconThemeData(color: AppColors.white, size: 24),
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.white)
  );
}