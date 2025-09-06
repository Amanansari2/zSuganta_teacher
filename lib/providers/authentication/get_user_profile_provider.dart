import 'package:flutter/cupertino.dart';
import 'package:z_tutor_suganta/models/authentications/login_model.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';

class GetUserProfileProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // GetUserProfileProvider(){
  //   fetchUserProfile();
  // }

  Future<void> fetchUserProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try{
      final response = await authenticationRepo.getUserProfile();

      if(response['success'] == true){
        _user = UserModel.fromJson(response['data']['user']);
        await LocalStorageService.saveUser(_user!);
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




}