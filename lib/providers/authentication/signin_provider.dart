
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:z_tutor_suganta/providers/authentication/get_user_profile_provider.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';

import '../../utils/constants/text_strings.dart';
import '../../widgets/dialog/custom_dialog.dart';

class SignInProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();
  final GetUserProfileProvider getUserProfileProvider = GetUserProfileProvider();


  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final resendEmailController = TextEditingController();
  final passwordController = TextEditingController();


  Map<String, dynamic> get signInData => {

      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "device_name": "mobile device"
  };


  bool _isloading = false;
  bool get isLoading => _isloading;

  Future<void> signIn(BuildContext context) async {

    if(!formKey.currentState!.validate()) return;
    _isloading = true;
    notifyListeners();

    try{
      final response = await authenticationRepo.signIn(signInData);

      if(response['success'] == true){
        final token = response['data']['token'];

       await LocalStorageService.saveToken(token);

       await getUserProfileProvider.fetchUserProfile();

        final localSavedToken = await LocalStorageService.getToken();


          LoggerHelper.debug(
              "Token -->>> $localSavedToken"
          );

        context.goNamed('bottomBar');

      }
      else if(response['message'].toString().contains("Email not verified")){
        context.pushNamed('resendEmail');
      }
      else {
        CustomDialog.show(
            context,
            title: AppText.error,
            message: response['message'],
          positiveButtonText: AppText.retry,
          onPositivePressed: (){},
          icon: FontAwesomeIcons.triangleExclamation,

        );
      }
    }catch(e){
      CustomDialog.show(
          context,
          title: AppText.error,
          message: e.toString(),
          positiveButtonText: AppText.retry,
        onPositivePressed: (){},
        icon: FontAwesomeIcons.triangleExclamation,

      );
    } finally{
      _isloading = false;
      notifyListeners();
    }
  }

  Map<String, dynamic> get resendEmailData => {

    "email": resendEmailController.text.trim(),
  };


  Future<void> verifyEmail(BuildContext context) async {
    if(!formKey.currentState!.validate()) return;
    _isloading = true;
    notifyListeners();
    try{
      final response = await authenticationRepo.verifyEmail(resendEmailData);
      if(response['success'] == true){
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
           onPositivePressed: (){
              context.goNamed('signIn');
           },
          icon: FontAwesomeIcons.checkCircle
        );
      } else{
        CustomDialog.show(
          context,
          title: AppText.error,
          message: response['message'],
          positiveButtonText: AppText.retry,
          onPositivePressed: (){},
          icon: FontAwesomeIcons.triangleExclamation,

        );
      }
    }catch(e){
      CustomDialog.show(
        context,
        title: AppText.error,
        message: e.toString(),
        positiveButtonText: AppText.retry,
        onPositivePressed: (){},
        icon: FontAwesomeIcons.triangleExclamation,

      );
    }finally{
      _isloading = false;
      notifyListeners();
    }
  }

}