import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/classes/all_classes_provider.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';

import '../../models/accounts/options_model.dart';
import '../../models/classes/class_detailed_model.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_function.dart';
import '../../utils/helpers/logger_helper.dart';
import '../../utils/helpers/user_sessions.dart';
import 'package:collection/collection.dart';

import '../../widgets/dialog/custom_dialog.dart';

class EditClassProvider  extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  Future<void> init(UserSessionProvider sessions, ClassDetailedModel classDetails) async{
    await fetchOptions(sessions);
    prefill(classDetails);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;


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

  Future<void> fetchOptions(UserSessionProvider sessions,  ) async {
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

  DateTime? _originalDate;


  Future<void> prefill(ClassDetailedModel classDetails) async {
    classTitleController.text = classDetails.title;
    descriptionController.text = classDetails.description ?? '';
    _originalDate = classDetails.date;
    dateController.text = classDetails.date.toIso8601String().split('T').first;
    timeController.text = classDetails.time;
    durationController.text = classDetails.duration.toString();
    maxStudentsController.text = classDetails.maxStudents.toString();
    priceController.text = classDetails.price;
    locationController.text = classDetails.location ?? '';

    if (teachers.isNotEmpty) {
      selectedTeacher = teachers.firstWhereOrNull((t) => t.id == classDetails.teacher.id);
    }
    if (subjects.isNotEmpty) {
      selectedSubject = subjects.firstWhereOrNull((s) => s.id == classDetails.subject.id);
    }
    if (exam.isNotEmpty) {
      selectedExam = exam.firstWhereOrNull((e) => e.id == classDetails.exam.id);
    }
    if (examCategories.isNotEmpty) {
      selectedExamCategory = examCategories.firstWhereOrNull(
              (c) => c.id == classDetails.examCategory.id);
    }
    if (type.isNotEmpty) {
      selectedType = type.firstWhereOrNull((t) => t.id.toString() == classDetails.type);
    }
    notifyListeners();
  }

  String _formattedOriginalDate() => _originalDate?.toIso8601String().split('T').first ?? '';

  Map<String, dynamic> get data =>{

    "title": classTitleController.text.trim(),
    "description": descriptionController.text.trim(),
    "date": (dateController.text.trim().isEmpty || dateController.text.trim() == _formattedOriginalDate())
        ? _formattedOriginalDate()
        : HelperFunction.formatApiDate(dateController.text),
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

  Future<void> editClass(BuildContext context, {required int classId}) async {
    if(!formKey.currentState!.validate()) return;

    _isLoading = true;
    notifyListeners();
    try {
      final response = await authenticationRepo.editClass(
          data, classId: classId);
      if (response['success'] == true) {
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
            onPositivePressed: () async {
              final provider = context.read<AllClassesProvider>();
              await provider.fetchClassDetails(context, classId: classId);
              context.pop();
            },
            backButtonBlock: true,
            dismissible: false,
            icon: FontAwesomeIcons.circleCheck
        );
      } else {
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


  @override
  void dispose() {
    classTitleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    durationController.dispose();
    maxStudentsController.dispose();
    priceController.dispose();
    locationController.dispose();
    super.dispose();
  }



}