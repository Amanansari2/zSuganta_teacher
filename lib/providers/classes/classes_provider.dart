import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:z_tutor_suganta/models/accounts/options_model.dart';
import 'package:z_tutor_suganta/models/classes/profile_completion_model.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/helpers/helper_function.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';
import 'package:z_tutor_suganta/widgets/dialog/custom_dialog.dart';

import '../../utils/constants/text_strings.dart';

class ClassesProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  Future<void> init(UserSessionProvider sessions) async{
    await fetchOptions(sessions);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProfileCompletionModel? _profileCompletion;
  ProfileCompletionModel? get profileCompletion => _profileCompletion;

Future<void>  fetchProfilePercentage(BuildContext context) async{

  _isLoading = true;
  notifyListeners();

  try{
      final response = await authenticationRepo.getProfileCompletePercentage();
      if(response['success'] == true && response['data'] != null){
        _profileCompletion = ProfileCompletionModel.fromJson(response['data']);
      }
  }catch(e){
    LoggerHelper.info("Error fetching profile percentage : $e");
  } finally{
    _isLoading = false;
    notifyListeners();
  }
}

//----------------------------------------------------------------------------------------------

final formKey = GlobalKey<FormState>();
final classTitleController = TextEditingController();
final descriptionController = TextEditingController();
final dateController = TextEditingController();
final timeController = TextEditingController();
final durationController = TextEditingController();
final maxStudentsController = TextEditingController();
final priceController = TextEditingController();
final locationController = TextEditingController();

// ---------- DROPDOWN OPTIONS ----------
List<FilterOption> teachers = [];
List<FilterOption> subjects = [];
List<FilterOption> exam = [];
List<FilterOption> examCategories = [];
List<TicketOptions> type = [];

// ---------- SELECTED VALUES ----------
 FilterOption? selectedTeacher;
 FilterOption? selectedSubject;
 FilterOption? selectedExam;
 FilterOption? selectedExamCategory;
 TicketOptions? selectedType;

// ---------- SETTER METHODS ----------

void setTeacher(FilterOption? option){
  selectedTeacher = option;
  notifyListeners();
}

  void setSubject(FilterOption? option){
    selectedSubject = option;
    notifyListeners();
  }

  void setExam(FilterOption? option){
    selectedExam = option;
    notifyListeners();
  }

  void setExamCategory(FilterOption? option){
    selectedExamCategory = option;
    notifyListeners();
  }

  void setType(TicketOptions? option){
  selectedType = option;
  notifyListeners();
  }

  Future<void> fetchOptions(UserSessionProvider sessions) async {
  _isLoading = true;
  notifyListeners();
  try{
    final cached = sessions.classOptions;
    if(cached != null){
      _setOptionsFromData(cached);
      LoggerHelper.info("Loaded class options from cache");
      _isLoading = false;
      notifyListeners();
      return;
    }
    final response = await authenticationRepo.getClassOptions();

    if(response['success'] == true){
      final data = response['data'];
      _setOptionsFromData(data);
      sessions.setClassOptions(data);
    }
  }catch(e){
    LoggerHelper.info("Error fetching teacher class Options");
  } finally{
    _isLoading = false;
    notifyListeners();
  }
  }

  void _setOptionsFromData(Map<String, dynamic>data){
      teachers = (data['teachers'] as List)
          .map((e) => FilterOption.fromJson(e))
          .toList();

      subjects = (data['subjects'] as List)
          .map((e) => FilterOption.fromJson(e))
          .toList();

      exam = (data['exams'] as List)
          .map((e) => FilterOption.fromJson(e))
          .toList();

      examCategories = (data['exam_categories'] as List)
          .map((e) => FilterOption.fromJson(e))
          .toList();

      type = (data['type'] as List)
          .map((e) => TicketOptions.fromJson(e))
          .toList();
  }



  Map<String, dynamic> get data =>{

      "title": classTitleController.text.trim(),
      "description": descriptionController.text.trim(),
      "date": HelperFunction.formatApiDate(dateController.text),
      "time": timeController.text.trim(),
      "duration": durationController.text.trim(),
      "subject_id": selectedSubject?.id,
      "exam_id": selectedExam?.id,
      "exam_category_id": selectedExamCategory?.id,
      "max_students": maxStudentsController.text.trim(),
      "price": priceController.text.trim(),
      "type": selectedType?.id,
      "location": locationController.text.trim(),
      "teacher_profile_id" : selectedTeacher?.id
  };


 Future<void> createClasses(BuildContext context) async {
   if(!formKey.currentState!.validate()) return;

   _isLoading = true;
   notifyListeners();

   try{
     final response = await authenticationRepo.createClass(data);

     LoggerHelper.info("Create class response ==>> $response");
     if(response['success'] == true){
       CustomDialog.show(
           context,
           title: AppText.success,
           message: response['message'],
           positiveButtonText: AppText.ok,
           onPositivePressed: (){
             resetForm();
           },
           dismissible: false,
           icon: FontAwesomeIcons.circleCheck
       );
     }else {
    String backendMessage = response['message'] ?? "Something went wrong";

       final errors = response['raw']?['data']?['errors'];
       if (errors != null && errors is Map) {
         final allMessages = <String>[];
         errors.forEach((key, value) {
           if (value is List) {
             for (var msg in value) {
               allMessages.add("$key: $msg");
             }
           } else {
             allMessages.add("$key: $value");
           }
         });
         if (allMessages.isNotEmpty) {
           backendMessage = allMessages.join("\n");
       }
     }
       CustomDialog.show(
         context,
         title: AppText.error,
         message: backendMessage,
         positiveButtonText: AppText.retry,
         onPositivePressed: () {},
         icon: FontAwesomeIcons.triangleExclamation,
       );
     }
   }catch(e){
     CustomDialog.show(
       context,
       title: AppText.error,
       message: e.toString(),
       positiveButtonText: AppText.retry,
       onPositivePressed: () {},
       icon: FontAwesomeIcons.triangleExclamation,
     );
   }finally{
     _isLoading = false;
     notifyListeners();
   }
 }


 void resetForm(){
   formKey.currentState?.reset();
   classTitleController.clear();
   descriptionController.clear();
   dateController.clear();
   timeController.clear();
   durationController.clear();
   maxStudentsController.clear();
   priceController.clear();
   locationController.clear();
   selectedTeacher == null;
   selectedSubject == null;
   selectedExam == null;
   selectedExamCategory == null;
   selectedType == null;
   notifyListeners();
 }

}