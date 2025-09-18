import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/helpers/helper_function.dart';
import 'package:z_tutor_suganta/widgets/dialog/custom_dialog.dart';

import '../authentication/get_user_profile_provider.dart';

class UpdateProfileProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();


  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final displayNameController = TextEditingController();
  final secondaryPhoneController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final bioController = TextEditingController();

  bool isImageUpdated = false;

  int? _gender;
  int? get gender => _gender;

  final Map<int, String> genderOptions = {
    1: "Male",
    2: "Female",
    3: "Other",
    4: "Prefer not to say",
  };


  void setGender(int? value){
    _gender = value;
    notifyListeners();
  }



  File? profileImage;



  Future<void> pickProfileImage(BuildContext context) async {
    try {
      PermissionStatus status;

      if (Platform.isAndroid) {
        if (await _isAndroid13OrAbove()) {
          status = await Permission.photos.request();
        } else {
          status = await Permission.storage.request();
        }

        if (status.isDenied) {
          return;
        } else if (status.isPermanentlyDenied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Permission permanently denied. Enable it in settings."),
            ),
          );
          openAppSettings();
          return;
        }
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        File pickedFile = File(result.files.single.path!);
        profileImage = pickedFile;
        isImageUpdated = true;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image selected successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image selection cancelled")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
  }

  Future<bool> _isAndroid13OrAbove() async {
    try {
      String version = Platform.operatingSystemVersion;
      return version.contains("13");
    } catch (_) {
      return false;
    }
  }




  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> updateProfile(BuildContext context) async {
    if(!formKey.currentState!.validate()) return;

    _isLoading = true;
    notifyListeners();
    try{

      final formData = FormData.fromMap({
        "address": addressController.text.trim(),
        "city": cityController.text.trim(),
        "state": stateController.text.trim(),
        "pincode": zipController.text.trim(),
        "country": "India",
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
        "display_name": displayNameController.text.trim(),
        "secondary_no": secondaryPhoneController.text.trim(),
        "dob": HelperFunction.formatDate(dobController.text),
        "gender": _gender,
        "bio": bioController.text.trim(),
        "area": areaController.text.trim(),

        if (isImageUpdated && profileImage != null)
          "profile_image": await MultipartFile.fromFile(
            profileImage!.path,
            filename: profileImage!.path.split('/').last,
          ),
      });

      final response = await authenticationRepo.updateUserProfile(formData);

      if(response['success'] == true){
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
          onPositivePressed: () async{
              final userProvider = Provider.of<GetUserProfileProvider>(context, listen: false);
            await userProvider.fetchUserProfile(context);

              context.pop();
          },
          dismissible: false,
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

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    displayNameController.dispose();
    secondaryPhoneController.dispose();
    dobController.dispose();
    addressController.dispose();
    areaController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    bioController.dispose();
    super.dispose();
  }

}