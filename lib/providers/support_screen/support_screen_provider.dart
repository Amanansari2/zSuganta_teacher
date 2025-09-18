import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:z_tutor_suganta/models/accounts/options_model.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';

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
}