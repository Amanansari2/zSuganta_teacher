import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';

import '../../models/accounts/tickets/ticket_details_model.dart';
import '../../utils/constants/text_strings.dart';
import '../../widgets/dialog/custom_dialog.dart';

class TicketDetailsProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TicketDetails? _ticketDetails;
  TicketDetails? get ticketDetails => _ticketDetails;


  Future<TicketDetails?> fetchTicketDetails(BuildContext context, {required int ticketId}) async {
    _isLoading = true;
    notifyListeners();
    TicketDetails? details;
    try{
      final response = await authenticationRepo.getTicketDetails(ticketId: ticketId);
      if(response['success'] == true){
         _ticketDetails = TicketDetails.fromJson(response['data'] ?? {});

       details = _ticketDetails;
      }else{
        CustomDialog.show(
          context,
          title: AppText.error,
          message: response['message'] ?? "something went wrong",
          positiveButtonText: AppText.retry,
          onPositivePressed: (){},
          icon: FontAwesomeIcons.triangleExclamation,
        );
      }
    } catch(e){
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
    return details;
  }


  File? uploadedFile;
  final TextEditingController replyController = TextEditingController();

  Future<void>  replyTicket(BuildContext context, {required int ticketId}) async {
   _isLoading = true;
   notifyListeners();
   try{
     final formData = FormData.fromMap({
       "message" : replyController.text.trim(),
       if(uploadedFile != null)
         "attachment" : await MultipartFile.fromFile(uploadedFile!.path)
     });
     
     final response = await authenticationRepo.replyTicket(formData, ticketId: ticketId);

     if(response['success'] == true){
       CustomDialog.show(
           context,
           title: AppText.success,
           message: response['message'],
           positiveButtonText: AppText.ok,
           onPositivePressed: () async{
             await fetchTicketDetails(context, ticketId: ticketId);
           },
           dismissible: true,
           icon: FontAwesomeIcons.checkCircle
       );
     } else{
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
         backButtonBlock: true,
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
  } finally{
     _isLoading = false;
     notifyListeners();
   }
   }

   Future<void> closeTicket(BuildContext context, {required int ticketId}) async {
    _isLoading = true;
    notifyListeners();
    try{
      final response = await authenticationRepo.closeTicket(ticketId: ticketId);

      if(response['success'] == true){
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
            onPositivePressed: () async{
              await fetchTicketDetails(context, ticketId: ticketId);
            },
            dismissible: true,
            icon: FontAwesomeIcons.checkCircle
        );
      }else{
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
          backButtonBlock: true,
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





