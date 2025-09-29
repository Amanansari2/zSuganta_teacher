import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/authentication/get_user_profile_provider.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';
import 'package:collection/collection.dart';
import 'package:z_tutor_suganta/widgets/dialog/custom_dialog.dart';


import '../../models/accounts/options_model.dart';
import '../classes/classes_provider.dart';

class InstituteInformationProvider extends ChangeNotifier{

  void init(UserSessionProvider sessions) async {
    await fetchOptions(sessions);
    loadFromLocal(sessions);
  }

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  final formKey = GlobalKey<FormState>();
  final instituteNameController = TextEditingController();
  final principalNameController = TextEditingController();
  final principalPhoneController = TextEditingController();
  final instituteDescriptionController = TextEditingController();

  //--------------------DropDown Options ------------
  List<FilterOption> instituteType = [];
  List<FilterOption> instituteCategory = [];
  List<FilterOption> establishmentYear = [];
  List<FilterOption> totalStudent = [];
  List<FilterOption> totalTeacher = [];


  // ------------------ Selected value ---------------

FilterOption? selectedInstituteType;
FilterOption? selectedInstituteCategory;
FilterOption? selectedEstablishmentYear;
FilterOption? selectedTotalStudents;
FilterOption? selectedTotalTeacher;

   //----------------Setter Methods -------------

   void setInstituteType(FilterOption? options){
     selectedInstituteType = options;
     notifyListeners();
   }

   void setInstituteCategory(FilterOption? options){
     selectedInstituteCategory = options;
     notifyListeners();
   }

   void setEstablishmentYear(FilterOption? options){
     selectedEstablishmentYear = options;
     notifyListeners();
   }

   void setTotalStudents(FilterOption? options){
     selectedTotalStudents = options;
     notifyListeners();
   }

   void setTotalTeacher(FilterOption? options){
     selectedTotalTeacher = options;
     notifyListeners();
   }


   void loadFromLocal(UserSessionProvider sessions){
     final institute = sessions.instituteProfile;
     if(institute == null) return;

     instituteNameController.text = institute.instituteName ?? '';
     principalNameController.text = institute.principalName ?? '';
     principalPhoneController.text = institute.principalPhone ?? '';
     instituteDescriptionController.text = institute.instituteDescription ?? '';
      selectedInstituteType = instituteType
           .firstWhereOrNull((opt) => opt.id == institute.instituteTypeId);

      selectedInstituteCategory = instituteCategory
          .firstWhereOrNull((opt) => opt.id == institute.instituteCategoryId);

      selectedEstablishmentYear = establishmentYear
          .firstWhereOrNull((opt) => opt.id == institute.establishmentYearId);

      selectedTotalStudents = totalStudent
          .firstWhereOrNull((opt) => opt.id == institute.totalStudentId);

      selectedTotalTeacher = totalTeacher
          .firstWhereOrNull((opt) => opt.id == institute.totalTeacherId);

      notifyListeners();
   }


   bool _isLoading = false;
   bool get isLoading => _isLoading;

   Future<void> fetchOptions(UserSessionProvider session) async {
     _isLoading = true;
     notifyListeners();

     try{
       final cached = session.instituteOptions;
       if(cached != null){
         _setOptionsFromData(cached);
         LoggerHelper.info("Loaded institute options from cache");
         _isLoading = false;
         notifyListeners();
         return;
       }

       final response = await authenticationRepo.getInstituteOptions();

       if(response['success'] == true){
         final data = response['data'];
         _setOptionsFromData(data);

         session.setInstituteOptions(data);
       }
     }catch(e){
       LoggerHelper.info("Error fetching institute options: $e");
     }

     _isLoading = false;
     notifyListeners();
   }


   void _setOptionsFromData(Map<String, dynamic>data){
     List<FilterOption> parseOptions(List<dynamic>? list) {
       if (list == null) return [];
       return list.map((e) => FilterOption.fromJson(e)).toList();
     }

     instituteType = parseOptions(data['institute_type']);
     instituteCategory = parseOptions(data['institute_category']);
     establishmentYear = parseOptions(data['establishment_year_range']);
     totalStudent = parseOptions(data['total_students_range']);
     totalTeacher = parseOptions(data['total_teachers_range']);


   }


   Map<String, dynamic> get instituteData => {

     "institute_name": instituteNameController.text.trim(),
     "institute_type_id": selectedInstituteType?.id,
     "institute_category_id": selectedInstituteCategory?.id,
     "establishment_year_id": selectedEstablishmentYear?.id,
     "principal_name": principalNameController.text.trim(),
     "principal_phone": principalPhoneController.text.trim(),
     "total_students_id": selectedTotalStudents?.id,
     "total_teachers_id": selectedTotalTeacher?.id,
     "institute_description": instituteDescriptionController.text.trim()
   };

   Future<void> updateInstituteInfo(BuildContext context) async {
     if(!formKey.currentState!.validate()) return;
     _isLoading = true;
     notifyListeners();
     try{
       final response = await authenticationRepo.updateInstituteProfile(instituteData);
       if(response['success'] == true){
         CustomDialog.show(
             context,
             title: AppText.success,
             message: response['message'],
             positiveButtonText:  AppText.ok,
           onPositivePressed: () async {
               final instituteProvider = Provider.of<GetUserProfileProvider>(context, listen: false);
               final classProvider = context.read<ClassesProvider>();
               await instituteProvider.fetchInstituteProfile(context);
             await  classProvider.fetchProfilePercentage(context);


               context.pop();
           },
           dismissible: false,
           icon:  FontAwesomeIcons.checkCircle
         );
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