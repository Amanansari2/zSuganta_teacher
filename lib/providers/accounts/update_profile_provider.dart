import 'package:flutter/cupertino.dart';

class UpdateProfileProvider extends ChangeNotifier{

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final displayNameController = TextEditingController();
  final secondaryPhoneController = TextEditingController();
  final dobController = TextEditingController();


}