import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';

import '../../utils/constants/text_strings.dart';
import '../../widgets/dialog/custom_dialog.dart';

class LogoutProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> logoutFRomCurrentDevice(BuildContext context) async{
    _isLoading = true;
    notifyListeners();
    try{
      final response = await authenticationRepo.logoutFromCurrentDevice();
      if(response['success'] == true){
          context.read<UserSessionProvider>().logout();
      }else{
        String backendMessage = response['message'] ?? 'Something went wrong';
        if(response['raw']?['errors'] != null && response['raw']['errors'] is Map){
          final errors = response['raw']['errors'] as Map<String, dynamic>;
          if(errors.isNotEmpty){
            final allMessage = errors.values
                .whereType<List>()
                .expand((list) => list)
                .map((e) => e.toString())
                .toList();

            if(allMessage.isNotEmpty){
              backendMessage = allMessage.join("\n");
            }
          }
        }
        CustomDialog.show(
            context,
            title: AppText.error,
            message: backendMessage,
            positiveButtonText: AppText.retry,
            onPositivePressed: (){},
            icon: FontAwesomeIcons.triangleExclamation
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


  Future<void> logoutFRomAllDevice(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try{
      final response = await authenticationRepo.logoutFromAllDevices();
      if(response['success'] == true){
        context.read<UserSessionProvider>().logout();
      }else{
        String backendMessage = response['message'] ?? 'Something went wrong';
        if(response['raw']?['errors'] != null && response['raw']['errors'] is Map){
          final errors = response['raw']['errors'] as Map<String, dynamic>;
          if(errors.isNotEmpty){
            final allMessage = errors.values
                .whereType<List>()
                .expand((list) => list)
                .map((e) => e.toString())
                .toList();

            if(allMessage.isNotEmpty){
              backendMessage = allMessage.join("\n");
            }
          }
        }
        CustomDialog.show(
            context,
            title: AppText.error,
            message: backendMessage,
            positiveButtonText: AppText.retry,
            onPositivePressed: (){},
            icon: FontAwesomeIcons.triangleExclamation
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