


import 'package:flutter/material.dart';
import 'package:z_tutor_suganta/models/accounts/institute_profile_model.dart';
import 'package:z_tutor_suganta/models/accounts/social_link_model.dart';
import 'package:z_tutor_suganta/models/authentications/login_model.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';

import '../../models/accounts/teacher_profile_model.dart';

class UserSessionProvider extends ChangeNotifier {
  UserModel? _currentUser;
  SocialModel? _currentSocial;
  Map<String, dynamic>? _teacherOptions;
  Map<String, dynamic>? _teacherSubjects;
  TeacherProfileModel? _teacherProfile;
  Map<String, dynamic>? _instituteOptions;
  InstituteProfileModel? _instituteProfile;

  UserModel? get currentUser => _currentUser;
  SocialModel? get currentSocial => _currentSocial;
  Map<String, dynamic>? get teacherOptions => _teacherOptions;
  Map<String, dynamic>? get teacherSubjects => _teacherSubjects;
  TeacherProfileModel? get teacherProfile => _teacherProfile;
  Map<String, dynamic>? get instituteOptions => _instituteOptions;
  InstituteProfileModel? get instituteProfile => _instituteProfile;

  String get role => _currentUser?.role ?? 'user';
  bool get isLoggedIn => _currentUser != null;

  void init() {
    _currentUser = LocalStorageService.getUser();
    _currentSocial = LocalStorageService.getSocial();
    notifyListeners();
  }

  void setUser(UserModel user) {
    _currentUser = user;
    LocalStorageService.saveUser(user);
    notifyListeners();
  }

  void setSocial(SocialModel social) {
    _currentSocial = social;
    LocalStorageService.saveSocialProfile(social);
    notifyListeners();
  }

  void setTeacherOptions(Map<String, dynamic> options) {
    _teacherOptions = options;
    LocalStorageService.saveTeacherOptions(options);
    notifyListeners();
  }

  void setTeacherSubjects(Map<String, dynamic> subjects){
    _teacherSubjects = subjects;
    LocalStorageService.saveTeacherSubjects(subjects);
    notifyListeners();
  }

  void setTeacherProfile(TeacherProfileModel teacher){
    _teacherProfile = teacher;
    LocalStorageService.saveTeacherProfile(teacher);
    notifyListeners();
  }

  void setInstituteOptions(Map<String, dynamic>instituteOptions){
    _instituteOptions = instituteOptions;
    LocalStorageService.saveInstituteOptions(instituteOptions);
    notifyListeners();
  }

  void setInstituteProfile(InstituteProfileModel institute){
    _instituteProfile = institute;
    LocalStorageService.saveInstituteProfile(institute);
    notifyListeners();
  }

  void logout() async {
    _currentUser = null;
    _currentSocial = null;
    _teacherOptions = null;
    _teacherSubjects = null;
    _instituteOptions = null;
    await LocalStorageService.clearAuthDataRedirect();
    notifyListeners();
  }


}
