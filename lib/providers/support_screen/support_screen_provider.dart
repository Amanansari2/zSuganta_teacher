import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/models/accounts/options_model.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';

import '../../utils/constants/text_strings.dart';
import '../../widgets/dialog/custom_dialog.dart';

class SupportScreenProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();


 Future<void> init(UserSessionProvider sessions) async {
    await fetchTicketOptions(sessions);
  }


  final formKey = GlobalKey<FormState>();
 final messageController = TextEditingController();

  File? uploadedFile;

  //--------------------DropDown Options ------------
  List<TicketOptions> categories = [];
  List<TicketOptions> priorities = [];

// ------------------ Selected value ---------------
  TicketOptions? selectedCategory;
  TicketOptions? selectedPriorities;

//----------------Setter Methods -------------
  void setCategory(TicketOptions? options){
    selectedCategory = options;
    notifyListeners();
  }

  void setPriorities(TicketOptions? options){
    selectedPriorities = options;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchTicketOptions(UserSessionProvider sessions) async {
    _isLoading = true;
    notifyListeners();

    try{
      final cached = sessions.ticketOptions;
      if(cached != null){
        _setOptionsFromData(cached);
        LoggerHelper.info("Loaded ticket options from cache");
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await authenticationRepo.getTicketOptions();

      if(response['success'] == true){
        final data = response['data'];
        _setOptionsFromData(data);

        sessions.setTicketOptions(data);
      }
    }catch(e){
      LoggerHelper.info("Error fetching ticket options $e");
    }

    _isLoading = false;
    notifyListeners();
  }


  void _setOptionsFromData(Map<String, dynamic>data){
    categories = (data['categories'] as List)
        .map((e) => TicketOptions.fromJson(e))
        .toList();

    priorities = (data['priorities'] as List)
        .map((e) => TicketOptions.fromJson(e))
        .toList();
  }

  Future<void>  submitTicket(BuildContext context) async {
    if(!formKey.currentState!.validate()) return;

    _isLoading = true;
    notifyListeners();
    try{
      final formData = FormData.fromMap({
        "priority" : selectedPriorities?.id,
        "category": selectedCategory?.id,
        "message": messageController.text.trim(),
        if(uploadedFile != null)
        "attachment": await MultipartFile.fromFile(
          uploadedFile!.path,
        )
      });

      final response = await authenticationRepo.submitTicket(formData);

      if(response['success'] == true){
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
            onPositivePressed: (){
             resetForm();
            },
            negativeButtonText:AppText.viewTicket ,
            onNegativePressed: (){
              resetForm();
              context.pushNamed('supportTicketListScreen');

            },
            backButtonBlock: true,
            dismissible: false,
            icon: FontAwesomeIcons.checkCircle
        );
      }else {
        String backendMessage = response['message'] ?? "Something went wrong";
        if(response['raw']?['errors'] != null && response['raw']['errors'] is Map){
          final errors = response['raw']['errors'] as Map<String, dynamic>;
          if(errors.isNotEmpty){
            final firstFiled = errors.keys.first;
            final firstErrorList = errors[firstFiled];
            if(firstErrorList is List && firstErrorList.isNotEmpty){
              backendMessage = firstErrorList.first.toString();
            }
          }
        }
        CustomDialog.show(
          context,
          title: AppText.error,
          message: backendMessage,
          positiveButtonText: AppText.retry,
          backButtonBlock:true,
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

  void resetForm() {
    messageController.clear();
    uploadedFile = null;
    selectedCategory = null;
    selectedPriorities = null;
    formKey.currentState?.reset();
    notifyListeners();
  }

  @override
  void dispose() {
     messageController.dispose();
    super.dispose();
  }
}