import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';

import '../../utils/constants/text_strings.dart';
import '../../widgets/dialog/custom_dialog.dart';

class EmailMobileProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool _isDialogOpen = false;
  bool get isDialogOpen => _isDialogOpen;

  void setDialogOpen(bool value) {
    _isDialogOpen = value;
    notifyListeners();
  }

  Map<String, dynamic> get emailMobile => {
    "email": emailController.text.trim(),
    "phone": phoneController.text.trim()
  };

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> emailPhone(BuildContext context) async {
    if(!formKey.currentState!.validate()) return;

    _isLoading = true;
    notifyListeners();

    try{
      final response = await authenticationRepo.emailPhone(emailMobile);

      if(response['success'] == true){
        setDialogOpen(true);
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
            onPositivePressed: () async{
              context.read<UserSessionProvider>().logout();
            },
            backButtonBlock: true,
            dismissible: false,
            icon: FontAwesomeIcons.checkCircle
        );
      }else{
        String backendMessage = response['message'] ?? "Something went wrong";
        if(response['raw']?['errors'] != null && response['raw']['errors'] is Map){
          final errors = response['raw']['errors'] as Map<String, dynamic>;
          if(errors.isNotEmpty){
            final allMessages = errors.values
                .whereType<List>()
                .expand((list) => list
            .map((e) => e.toString())
            ).toList();
            if(allMessages.isNotEmpty){
              backendMessage = allMessages.join("\n");
            }
          }
        }
        CustomDialog.show(
          context,
          title: AppText.error,
          message: backendMessage,
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
      _isLoading = false;
      notifyListeners();
    }
  }
}