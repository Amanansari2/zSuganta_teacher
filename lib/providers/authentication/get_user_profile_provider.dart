import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/models/accounts/institute_profile_model.dart';
import 'package:z_tutor_suganta/models/accounts/teacher_profile_model.dart';
import 'package:z_tutor_suganta/models/authentications/login_model.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';

import '../../models/accounts/social_link_model.dart';
import '../../utils/helpers/user_sessions.dart';

class GetUserProfileProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;



  Future<void> fetchUserProfile(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try{
      final response = await authenticationRepo.getUserProfile();

      if(response['success'] == true){
        final user = UserModel.fromJson(response['data']['user']);
        context.read<UserSessionProvider>().setUser(user);
        final userdata = await LocalStorageService.getUser();
        LoggerHelper.info("Local user data -->>> $userdata");
      } else{
        _error = response['message'] ?? "Something went Wrong";
      }
    }catch(e){
      _error = e.toString();
      LoggerHelper.info("Error fetching latest user profile $e");
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  //----------->> get social profile url

  bool _isSocialLoading = false;
  String? _errorSocial;

  bool get isSocialLoading => _isSocialLoading;
  String? get errorSocial => _errorSocial;


  Future<void> fetchSocialProfile(BuildContext context) async{
    _isSocialLoading = true;
    _errorSocial = null;
    notifyListeners();
    try{
      final response = await authenticationRepo.getSocialProfile();

      if(response['success'] == true) {
        final social = SocialModel.fromJson(response['data']['social_links']);
        context.read<UserSessionProvider>().setSocial(social);
        final socialData = await LocalStorageService.getSocial();
        LoggerHelper.info("Local social profile url data -->> $socialData");
      } else{
        _errorSocial = response['message'] ?? "Something went wrong";
      }
    }catch(e){
      _errorSocial = e.toString();
      LoggerHelper.info("Error fetching latest social profile urls $e");
    } finally{
      _isSocialLoading = false;
      notifyListeners();
    }
  }

  //----------->> get teacher profile 

  bool _isTeacherLoading = false;
  String? _errorTeacher;

  bool get isTeacherLoading => _isTeacherLoading;
  String? get errorTeacher => _errorTeacher;

  Future<void> fetchTeacherProfile(BuildContext context) async{
    _isTeacherLoading = true;
    _errorTeacher = null;
    notifyListeners();
    try{
      final response = await authenticationRepo.getTeacherProfile();

      if(response['success'] == true){
        final teacher = TeacherProfileModel.fromJson(response['data']['teacher_profile']);
        context.read<UserSessionProvider>().setTeacherProfile(teacher);
        final teacherData = await LocalStorageService.getTeacherProfile();
        LoggerHelper.info("Local teacher profile url Data -->> $teacherData");
      }else{
        _errorTeacher = response['message']?? "Something went wrong";

      }
    }catch(e){
      _errorTeacher = e.toString();
      LoggerHelper.info("Error fetching latest teacher profile urls $e");
    }finally{
      _isTeacherLoading = false;
      notifyListeners();
    }

  }


//----------->> get institute profile

  bool _isInstituteLoading = false;
  String? _errorInstitute;
  
  bool get isInstituteLoading => _isInstituteLoading;
  String? get errorInstitute => _errorInstitute;
  
  Future<void> fetchInstituteProfile(BuildContext context) async {
    _isInstituteLoading = true;
    _errorInstitute = null;
    notifyListeners();
    try{
      final response = await authenticationRepo.getInstituteProfile();
      if(response['success'] == true){
        final institute = InstituteProfileModel.fromJson(response['data']['institute_profile']);
        context.read<UserSessionProvider>().setInstituteProfile(institute);
        final instituteData = await LocalStorageService.getInstituteProfile();
        LoggerHelper.info("Local Institute profile url data -->> $instituteData");
      }else{
        _errorInstitute = response['message']?? 'Something went wrong';
      }
    }catch(e){
      _errorInstitute = e.toString();
      LoggerHelper.info("Error fetching latest institute profile urls $e");
    }finally{
      _isInstituteLoading = false;
      notifyListeners();
    }
  }
  
  
}