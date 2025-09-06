import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_tutor_suganta/models/authentications/login_model.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/widgets/dialog/session_expired_dialog.dart';


class LocalStorageService{

  static late SharedPreferences _prefs;

  static const String _themeKey = "themeMode";
  static const String _onboardingKey = "onboarding_seen";
  static const String _tokenKey = "auth_token";
  static const String _userKey = "user";


  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

//_________________________Theme
///-->> save Theme
  static Future<void> saveTheme(ThemeMode themeMode) async {
    await _prefs.setInt(_themeKey, themeMode.index);
  }

///-->> Get Theme
   static Future<ThemeMode> getTheme() async {
     final index = _prefs.getInt(_themeKey);
     if(index != null){
       return ThemeMode.values[index];
     }
     return ThemeMode.system;
   }


//_________________________Onboarding
  ///-->> save onboarding
  static Future<void> setOnboardingSeen() async {
    await _prefs.setBool(_onboardingKey, true);
  }

  ///-->> check onboard seen
  static bool isOnboardingSeen() {
    return _prefs.getBool(_onboardingKey) ?? false;
  }


//_________________________Token
///-->> save Token
 static Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
 }

///-->> Get Token
  static String? getToken()  {
    return _prefs.getString(_tokenKey);
}

//_________________________Login USer
///-->> save user
static Future<void> saveUser(UserModel user) async {
    await _prefs.setString(_userKey, jsonEncode(user.toJson()));
}

///-->> Get User
static Future<UserModel?> getUser() async {
    final userJson = _prefs.getString(_userKey);
    if(userJson == null ) return null;
    return UserModel.fromJson(jsonDecode(userJson));
}



//_________________________Clear and Redirect
static Future<void> clearAuthDataRedirect() async{
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userKey);
    LoggerHelper.info("Data Removed successfully--> token and user");

    // AppRouter.router.goNamed('signIn');
  SessionOverlay.showAndRedirect();
}
}