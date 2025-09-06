import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AppTextFormFiledTheme{

  AppTextFormFiledTheme._();


  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,

  labelStyle: const TextStyle().copyWith(fontSize: 14, color: AppColors.black),
  hintStyle: const TextStyle().copyWith(fontSize: 14, color: AppColors.black),
  errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
  floatingLabelStyle: const TextStyle().copyWith(color: AppColors.black.withOpacity(0.8)),
  border: const OutlineInputBorder().copyWith(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide(width: 1, color: Colors.grey)
  ),
  enabledBorder: const OutlineInputBorder().copyWith(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide(width: 1,color: Colors.grey)
  ),
  focusedBorder: const OutlineInputBorder().copyWith(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide(width: 1,color: Colors.black12)
  ),

  errorBorder: const OutlineInputBorder().copyWith(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide(width: 1,color: Colors.red)
  ),

  focusedErrorBorder: const OutlineInputBorder().copyWith(
  borderRadius: BorderRadius.circular(14),
  borderSide:  BorderSide(width: 2, color: AppColors.orange),
  ),


    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    filled: true,
    fillColor: AppColors.lightGrey,


    prefixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
    suffixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),

  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,

      labelStyle: const TextStyle().copyWith(fontSize: 14, color: AppColors.white),
      hintStyle: const TextStyle().copyWith(fontSize: 14, color: AppColors.white),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle: const TextStyle().copyWith(color: AppColors.white.withOpacity(0.8)),
      border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.grey)
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1,color: Colors.grey)
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1,color: AppColors.white)
      ),

      errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1,color: Colors.red)
      ),

      focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const  BorderSide(width: 2,color: AppColors.orange)
      ),

    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

    filled: true,
    fillColor: AppColors.darkGrey,

    prefixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
    suffixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
  );

}