import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/widgets/dialog/custom_dialog.dart';

class SignUpProvider extends ChangeNotifier{

  final AuthenticationRepo signupRepo = AuthenticationRepo();

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool agreeToTerms = false;


  // String countryCode = "+91";
  // String flagEmoji = "🇮🇳";
  //
  // void updateCountry(Country country){
  //   countryCode = "+${country.phoneCode}";
  //   flagEmoji = country.flagEmoji;
  //   notifyListeners();
  // }

  Map<String, String> roles = {
    "ngo": "NGO",
    "student": "Student",
    "institute": "Institute",
    "teacher": "Teacher",
  };

  String? selectedRoleKey;

  void updateRole(String? key){
    selectedRoleKey  = key;
    notifyListeners();
  }

  void toggleAgreeToTerms(bool value) {
    agreeToTerms = value;
    notifyListeners();
  }



  Map<String, dynamic> get signUpData => {
    "first_name": firstNameController.text.trim(),
    "last_name": lastNameController.text.trim(),
    "email": emailController.text.trim(),
    "password": passwordController.text.trim(),
    "password_confirmation": confirmPasswordController.text.trim(),
    "role":  selectedRoleKey,
    "phone": phoneController.text.trim()
  };

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> signup(BuildContext context) async {

    if (!formKey.currentState!.validate() || selectedRoleKey == null || !agreeToTerms) return;


    _isLoading = true;
    notifyListeners();
    try{
      final response = await signupRepo.signup(signUpData);

      if(response['success'] == true){
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
           onPositivePressed: (){
              resetForm();
              context.goNamed("signIn");
           },
          dismissible: false,
          icon: FontAwesomeIcons.checkCircle,

        );
      } else{
        String backendMessage = response['message'] ?? "Something went wrong";
        if (response['raw']?['errors'] != null && response['raw']['errors'] is Map) {
          final errors = response['raw']['errors'] as Map<String, dynamic>;
          if (errors.isNotEmpty) {
            final firstField = errors.keys.first;
            final firstErrorList = errors[firstField];
            if (firstErrorList is List && firstErrorList.isNotEmpty) {
              backendMessage = firstErrorList.first.toString();
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
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  int termsFieldKey = 0;
  void resetForm(){
    formKey.currentState?.reset();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    updateRole(null);
    toggleAgreeToTerms(false);
    termsFieldKey++;
    notifyListeners();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}