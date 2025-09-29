import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';

import '../../models/accounts/options_model.dart';
import '../../repository/authentication_repo.dart';
import '../../utils/constants/text_strings.dart';
import '../../widgets/dialog/custom_dialog.dart';
import '../authentication/get_user_profile_provider.dart';
import '../classes/classes_provider.dart';

class TeachingInformationProvider extends ChangeNotifier{

  void init(UserSessionProvider sessions) async {
    await fetchOptions(sessions);
    await fetchSubjects(sessions);
    loadFromLocal(sessions);
  }

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  final formKey = GlobalKey<FormState>();
  final universityCollegeController = TextEditingController();
  final graduationYearController = TextEditingController();
  final teachingPhilosophyController = TextEditingController();

  // ---------- DROPDOWN OPTIONS ----------
  List<FilterOption> travelRadius = [];
  List<FilterOption> hourlyRate = [];
  List<FilterOption> monthlyRate = [];
  List<FilterOption> teachingMode = [];
  List<FilterOption> availabilityStatus = [];
  List<FilterOption> highestQualification = [];
  List<FilterOption> fieldStudy = [];
  List<FilterOption> teachingExperience = [];
  List<SubjectOptions> subjectOption = [];

  // ---------- SELECTED VALUES ----------
  FilterOption? selectedTravelRadius;
  FilterOption? selectedHourlyRate;
  FilterOption? selectedMonthlyRate;
  FilterOption? selectedTeachingMode;
  FilterOption? selectedAvailabilityStatus;
  FilterOption? selectedHighestQualification;
  FilterOption? selectedFieldStudy;
  FilterOption? selectedTeachingExperience;
  List<SubjectOptions> selectedSubjects = [];


  // ---------- SETTER METHODS ----------


  void setTravelRadius(FilterOption? option) {
    selectedTravelRadius = option;
    notifyListeners();
  }

  void setHourlyRate(FilterOption? option) {
    selectedHourlyRate = option;
    notifyListeners();
  }

  void setMonthlyRate(FilterOption? option) {
    selectedMonthlyRate = option;
    notifyListeners();
  }

  void setTeachingMode(FilterOption? option) {
    selectedTeachingMode = option;
    notifyListeners();
  }

  void setAvailabilityStatus(FilterOption? option) {
    selectedAvailabilityStatus = option;
    notifyListeners();
  }

  void setHighestQualification(FilterOption? option) {
    selectedHighestQualification = option;
    notifyListeners();
  }

  void setFieldStudy(FilterOption? option) {
    selectedFieldStudy = option;
    notifyListeners();
  }

  void setTeachingExperience(FilterOption? option) {
    selectedTeachingExperience = option;
    notifyListeners();
  }

  void setSelectedSubject(SubjectOptions subject) {
    if (selectedSubjects.contains(subject)) {
      selectedSubjects.remove(subject);
    } else {
      selectedSubjects.add(subject);
    }
    notifyListeners();
  }



  void loadFromLocal(UserSessionProvider sessions) {
    final teacher = sessions.teacherProfile;
    if (teacher == null) return;

    universityCollegeController.text = teacher.institutionName ?? '';
    graduationYearController.text = teacher.graduationYear?.toString() ?? '';
    teachingPhilosophyController.text = teacher.teachingPhilosophy ?? '';

    selectedHighestQualification = highestQualification
        .firstWhereOrNull((opt) => opt.id == teacher.highestQualification);

    selectedFieldStudy = fieldStudy
        .firstWhereOrNull((opt) => opt.id == teacher.fieldOfStudy);

    selectedTeachingExperience = teachingExperience
        .firstWhereOrNull((opt) => opt.id == teacher.teachingExperienceYears);

    selectedHourlyRate = hourlyRate
        .firstWhereOrNull((opt) => opt.id == teacher.hourlyRate);

    selectedMonthlyRate = monthlyRate
        .firstWhereOrNull((opt) => opt.id == teacher.monthlyRate);

    selectedTravelRadius = travelRadius
        .firstWhereOrNull((opt) => opt.id == teacher.travelRadius);

    selectedTeachingMode = teachingMode
        .firstWhereOrNull((opt) => opt.id == teacher.teachingMode);

    selectedSubjects = subjectOption
        .where((opt) => teacher.subjectsTaught?.contains(opt.id) ?? false)
        .toList();

    selectedAvailabilityStatus = availabilityStatus
        .firstWhereOrNull((opt) => opt.id == teacher.availabilityStatus);

    notifyListeners();
  }



  bool _isLoading = false;
  bool get isLoading => _isLoading;


  Future<void> fetchOptions(UserSessionProvider sessions) async {
    _isLoading = true;
    notifyListeners();

    try {

      final cached = sessions.teacherOptions;
      if(cached!= null){
        _setOptionsFromData(cached);
        LoggerHelper.info("Loaded teacher options from cache");
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await authenticationRepo.getTeacherOptions();

      if (response['success'] == true) {
        final data = response['data'];
        _setOptionsFromData(data);

        sessions.setTeacherOptions(data);

      }
    } catch (e) {
      LoggerHelper.info("Error fetching teacher options: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void _setOptionsFromData(Map<String, dynamic> data){
    travelRadius = (data['travel_radius_km'] as List)
        .map((e) => FilterOption.fromJson(e))
        .toList();

    hourlyRate = (data['hourly_rate_range'] as List)
        .map((e) => FilterOption.fromJson(e))
        .toList();

    monthlyRate = (data['monthly_rate_range'] as List)
        .map((e) => FilterOption.fromJson(e))
        .toList();

    teachingMode = (data['teaching_mode'] as List)
        .map((e) => FilterOption.fromJson(e))
        .toList();

    availabilityStatus = (data['availability_status'] as List)
        .map((e) => FilterOption.fromJson(e))
        .toList();

    highestQualification = (data['highest_qualification'] as List)
        .map((e) => FilterOption.fromJson(e))
        .toList();

    fieldStudy = (data['field_of_study'] as List)
        .map((e) => FilterOption.fromJson(e))
        .toList();

    teachingExperience = (data['teaching_experience_years'] as List)
        .map((e) => FilterOption.fromJson(e))
        .toList();
  }

  Future<void> fetchSubjects(UserSessionProvider sessions) async{
    _isLoading = true;
    notifyListeners();
    try{

      final cached = sessions.teacherSubjects;
      if(cached != null){
        _setSubjectsFromData(cached);
        LoggerHelper.info("Loaded teacher subjects form cache");
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await authenticationRepo.getTeacherSubjects();
      if(response['success'] == true){
        final data = response['data'] ;
        _setSubjectsFromData(data);
        sessions.setTeacherSubjects(data);

      }
    }catch(e){
      LoggerHelper.info("Error fetching teacher subjects: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  void _setSubjectsFromData(Map<String, dynamic> data){
    subjectOption = (data['subjects'] as List)
        .map((e) => SubjectOptions.fromJson(e))
        .toList();

  }

  Map<String, dynamic> get teacherData => {

    "highest_qualification": selectedHighestQualification?.id,
    "institution_name": universityCollegeController.text.trim(),
    "field_of_study": selectedFieldStudy?.id,
    "graduation_year": int.tryParse(graduationYearController.text),
    "teaching_experience_years": selectedTeachingExperience?.id,
    "hourly_rate_id": selectedHourlyRate?.id,
    "monthly_rate_id": selectedMonthlyRate?.id,
    "travel_radius_km_id": selectedTravelRadius?.id,
    "teaching_mode_id": selectedTeachingMode?.id,
    "availability_status_id": selectedAvailabilityStatus?.id,
    "teaching_philosophy": teachingPhilosophyController.text.trim(),
    "subjects_taught": selectedSubjects.map((s) => s.id).toList(),
  };


  Future<void> updateTeacherInfo(BuildContext context) async {
    if(!formKey.currentState!.validate()) return;
    _isLoading = true;
    notifyListeners();
    try{
      final response = await authenticationRepo.updateTeachingInformation(teacherData);
      if(response['success'] == true){
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
            onPositivePressed: () async{
               final teacherProvider = Provider.of<GetUserProfileProvider>(context, listen: false);
               final classProvider = context.read<ClassesProvider>();
               await teacherProvider.fetchTeacherProfile(context);
               await classProvider.fetchProfilePercentage(context);
              context.pop();
            },
            dismissible: false,
            icon: FontAwesomeIcons.checkCircle
        );
      }else{
        String backendMessage = response['message'] ?? "Something went wrong";
        if (response['raw']?['errors'] != null && response['raw']['errors'] is Map) {
          final errors = response['raw']['errors'] as Map<String, dynamic>;
          if (errors.isNotEmpty) {
            final allMessages = errors.values
                .whereType<List>()
                .expand((list) => list)
                .map((e) => e.toString())
                .toList();

            if (allMessages.isNotEmpty) {
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


  @override
  void dispose() {
    universityCollegeController.dispose();
    graduationYearController.dispose();
    teachingPhilosophyController.dispose();
    super.dispose();
  }

}