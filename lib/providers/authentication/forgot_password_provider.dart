
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/widgets/dialog/custom_dialog.dart';

class ForgotPasswordProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();


  Map<String, dynamic> get forgotPasswordData => {
    "email" : emailController.text.trim()
  };

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> forgotPassword(BuildContext context) async {
    if(!formKey.currentState!.validate()) return;

    _isLoading = true;
    notifyListeners();

    try{
      final response = await authenticationRepo.forgotPassword(forgotPasswordData);
      if(response['success'] == true){
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
          positiveButtonText: AppText.ok,
          onPositivePressed: (){
              emailController.clear();
              context.pushNamed('signIn');
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
          icon: FontAwesomeIcons.triangleExclamation
        );
      }
    } catch(e){
      CustomDialog.show(
          context,
          title: AppText.error,
          message: e.toString(),
          positiveButtonText: AppText.retry,
        onPositivePressed: (){},
        icon: FontAwesomeIcons.triangleExclamation
      );
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}