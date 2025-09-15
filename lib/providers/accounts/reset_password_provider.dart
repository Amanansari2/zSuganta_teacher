import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';

import '../../utils/constants/text_strings.dart';
import '../../widgets/dialog/custom_dialog.dart';

class ResetPasswordProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();


  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Map<String, dynamic> get resetData => {
    "current_password": oldPasswordController.text.trim(),
    "password": newPasswordController.text.trim(),
    "password_confirmation": confirmPasswordController.text.trim()
  };

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> resetPassword(BuildContext context) async {
    if(!formKey.currentState!.validate()) return;
    _isLoading = true;
    notifyListeners();

    try{
      final response = await authenticationRepo.resetPassword(resetData);

      if(response['success'] == true){
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
            onPositivePressed: () async{

              context.pop();
            },
            dismissible: false,
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
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}