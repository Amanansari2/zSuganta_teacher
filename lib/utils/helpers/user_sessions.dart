import 'package:z_tutor_suganta/models/authentications/login_model.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';

class UserSessions{
  static late UserModel currentUser;

  static Future<void> init() async {
    final user = await LocalStorageService.getUser();
    if(user != null){
      currentUser = user;
    }
  }

  static String get role => currentUser.role;
}