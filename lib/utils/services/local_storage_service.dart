import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_tutor_suganta/models/accounts/institute_profile_model.dart';
import 'package:z_tutor_suganta/models/accounts/social_link_model.dart';
import 'package:z_tutor_suganta/models/accounts/teacher_profile_model.dart';
import 'package:z_tutor_suganta/models/authentications/login_model.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/widgets/dialog/session_expired_dialog.dart';


class LocalStorageService{

  static late SharedPreferences _prefs;

  static const String _themeKey = "themeMode";
  static const String _onboardingKey = "onboarding_seen";
  static const String _tokenKey = "auth_token";
  static const String _userKey = "user";
  static const String _socialKey = "social";
  static const String _teacherOptionsKey = "teacher_options";
  static const String _teacherOptionsTimestampKey = "teacher_options_timestamp";
  static const String _teacherSubjectsKey = "teacher_subjects";
  static const String _teacherSubjectsTimestampKey = "teacher_subjects_timestamp";
  static const String _teacherProfileKey = "teacher_profile";
  static const String _instituteOptionsKey = "institute_options";
  static const String _instituteOptionsTimestampKey = "institute_options_timestamp";
  static const String _instituteProfileKey = "institute_profile";
  static const String _ticketOptionsKey = "ticket_options";
  static const String _ticketOptionsTimestampKey = "ticket_options_timestamp";
  static const String _classOptionsKey = "class_options";
  static const String _classOptionsTimestampKey = "class_options_timestamp";



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
static UserModel? getUser() {
    final userJson = _prefs.getString(_userKey);
    if(userJson == null ) return null;
    return UserModel.fromJson(jsonDecode(userJson));
}

//_________________________Social Profile
  ///-->> save Social Profile
  static Future<void> saveSocialProfile(SocialModel social) async {
    await _prefs.setString(_socialKey, jsonEncode(social.toJson()));
}

///-->> get social profile
  static SocialModel? getSocial() {
    final socialJson = _prefs.getString(_socialKey);
    if(socialJson == null) return null;
    return SocialModel.fromJson(jsonDecode(socialJson));
  }



//_________________________Teacher options
///-->> save Teacher options
  static Future<void> saveTeacherOptions(Map<String, dynamic>options) async {
    await _prefs.setString(_teacherOptionsKey, jsonEncode(options));
    await _prefs.setString(_teacherOptionsTimestampKey, DateTime.now().toIso8601String());
  }



///-->> get teacher options
  static Map<String, dynamic>? getTeacherOptions() {
    final data = _prefs.getString(_teacherOptionsKey);
    final timestampStr = _prefs.getString(_teacherOptionsTimestampKey);

    if (data == null || timestampStr == null) return null;

    final savedAt = DateTime.tryParse(timestampStr);
    if (savedAt == null) return null;

    final now = DateTime.now();
    if (now.difference(savedAt).inDays >= 3) {
      _prefs.remove(_teacherOptionsKey);
      _prefs.remove(_teacherOptionsTimestampKey);
      LoggerHelper.info("Teacher options cache expired after 3 days");
      return null;
    }

    return jsonDecode(data);
  }




//_________________________Teacher subjects
///-->> save Teacher subjects
 static Future<void> saveTeacherSubjects(Map<String,dynamic> subjects) async{
    await _prefs.setString(_teacherSubjectsKey, jsonEncode(subjects));
    await _prefs.setString(_teacherSubjectsTimestampKey, DateTime.now().toIso8601String());
 }

///-->> get teacher subjects
  static Map<String, dynamic>? getTeacherSubjects(){
    final data = _prefs.getString(_teacherSubjectsKey);
    final timeStampStr = _prefs.getString(_teacherSubjectsTimestampKey);

    if(data == null || timeStampStr == null) return null;

    final savedAt = DateTime.tryParse(timeStampStr);
    if(savedAt == null) return null;

    final now = DateTime.now();
    if(now.difference(savedAt).inDays >= 3) {
      _prefs.remove(_teacherSubjectsKey);
      _prefs.remove(_teacherSubjectsTimestampKey);
      LoggerHelper.info("Teacher subjects cache expired after 3 days");
      return null;
    }
    return jsonDecode(data);
  }

//_________________________Teacher Profile
///-->> save Teacher Profile
  static Future<void> saveTeacherProfile(TeacherProfileModel teacher) async {
    await _prefs.setString(_teacherProfileKey, jsonEncode(teacher.toJson()));
  }

///-->> get social profile
  static TeacherProfileModel? getTeacherProfile() {
    final teacherJson = _prefs.getString(_teacherProfileKey);
    if(teacherJson == null) return null;
    return TeacherProfileModel.fromJson(jsonDecode(teacherJson));
  }



//_________________________Institute options
///-->> save Institute options
  static Future<void> saveInstituteOptions(Map<String, dynamic>instituteOptions) async{
    await _prefs.setString(_instituteOptionsKey, jsonEncode(instituteOptions));
    await _prefs.setString(_instituteOptionsTimestampKey, DateTime.now().toIso8601String());
  }

///-->> get Institute options
  static Map<String, dynamic>? getInstituteOptions(){
    final data = _prefs.getString(_instituteOptionsKey);
    final timestampStr = _prefs.getString(_instituteOptionsTimestampKey);

    if(data == null || timestampStr == null) return null;
    final savedAt = DateTime.tryParse(timestampStr);
    if(savedAt == null) return null;
    final now = DateTime.now();
    if(now.difference(savedAt).inDays >=3){
      _prefs.remove(_instituteOptionsKey);
      _prefs.remove(_instituteOptionsTimestampKey);
      LoggerHelper.info("Institute options cache expired after 3 days");
      return null;

    }

    return jsonDecode(data);
  }


///-->> save Institute Profile
  static Future<void> saveInstituteProfile(InstituteProfileModel institute) async{
    await _prefs.setString(_instituteProfileKey, jsonEncode(institute.toJson()));
  }

///-->> get Institute Profile
  static InstituteProfileModel? getInstituteProfile() {
    final instituteJson = _prefs.getString(_instituteProfileKey);
    if(instituteJson == null) return null;
    return InstituteProfileModel.fromJson(jsonDecode(instituteJson));
  }


//_________________________Ticket options
///-->> save Ticket options
  static Future<void> saveTicketOptions(Map<String, dynamic>ticketOptions) async{
    await _prefs.setString(_ticketOptionsKey, jsonEncode(ticketOptions));
    await _prefs.setString(_ticketOptionsTimestampKey, DateTime.now().toIso8601String());
  }

///-->> get Ticket options
  static Map<String, dynamic>? getTicketOptions(){
    final data = _prefs.getString(_ticketOptionsKey);
    final timestampStr = _prefs.getString(_ticketOptionsTimestampKey);

    if(data == null || timestampStr == null) return null;
    final savedAt = DateTime.tryParse(timestampStr);
    if(savedAt == null) return null;
    final now = DateTime.now();
    if(now.difference(savedAt).inDays >=3){
      _prefs.remove(_ticketOptionsKey);
      _prefs.remove(_ticketOptionsTimestampKey);
      LoggerHelper.info("Ticket options cache expired after 3 days");
      return null;

    }

    return jsonDecode(data);
  }

//_________________________Class options
///-->> save Class options
  static Future<void> saveClassOptions(Map<String, dynamic> options) async {
    await _prefs.setString(_classOptionsKey, jsonEncode(options));
    await _prefs.setString(_classOptionsTimestampKey, DateTime.now().toIso8601String());
  }

///-->> get Class options
  static Map<String, dynamic>? getClassOptions(){
    final data = _prefs.getString(_classOptionsKey);
    final timestampStr = _prefs.getString(_classOptionsTimestampKey);

    if(data == null || timestampStr == null) return null;

    final savedAt = DateTime.tryParse(timestampStr);
    if(savedAt == null) return null;

    final now = DateTime.now();
    if(now.difference(savedAt).inDays >= 3){
      _prefs.remove(_classOptionsKey);
      _prefs.remove(_classOptionsTimestampKey);
      LoggerHelper.info("Class options cache expired after 3 days");
      return null;
    }

    return jsonDecode(data);
  }


//_________________________Clear and Redirect
static Future<void> clearAuthDataRedirect() async{
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userKey);
    await _prefs.remove(_socialKey);
    await _prefs.remove(_teacherOptionsKey);
    await _prefs.remove(_teacherOptionsTimestampKey);
    await _prefs.remove(_teacherSubjectsKey);
    await _prefs.remove(_teacherSubjectsTimestampKey);
    await _prefs.remove(_teacherProfileKey);
    await _prefs.remove(_instituteOptionsKey);
    await _prefs.remove(_instituteOptionsTimestampKey);
    await _prefs.remove(_ticketOptionsKey);
    await _prefs.remove(_ticketOptionsTimestampKey);
    await _prefs.remove(_classOptionsKey);
    await _prefs.remove(_classOptionsTimestampKey);
    LoggerHelper.info("Data Removed successfully--> token, user, social links, teacher options, teacher subjects, teacher profile, institute options, ticket Options, class options");
  SessionOverlay.showAndRedirect();
}
}