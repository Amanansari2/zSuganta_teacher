import 'package:flutter/material.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';

class MyChipTheme{
  MyChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: AppColors.black),
    selectedColor: AppColors.orange,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor:  AppColors.white,
  );


  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: AppColors.white),
    selectedColor: AppColors.blue,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor:  AppColors.white,
  );
}