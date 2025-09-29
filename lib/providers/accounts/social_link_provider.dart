import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';

import '../../utils/constants/text_strings.dart';
import '../../widgets/dialog/custom_dialog.dart';
import '../authentication/get_user_profile_provider.dart';
import '../classes/classes_provider.dart';

class SocialLinkProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  final formKey = GlobalKey<FormState>();
  final facebookController = TextEditingController();
  final twitterController = TextEditingController();
  final instagramController = TextEditingController();
  final linkedinController = TextEditingController();
  final youtubeController = TextEditingController();
  final websiteController = TextEditingController();
  final whatsappController = TextEditingController();
  final telegramController = TextEditingController();


  Map<String, dynamic> get socialLinks => {
    "facebook_url": facebookController.text.trim(),
    "twitter_url": twitterController.text.trim(),
    "instagram_url": instagramController.text.trim(),
    "linkedin_url": linkedinController.text.trim(),
    "youtube_url": youtubeController.text.trim(),
    "website": websiteController.text.trim(),
    "whatsapp": whatsappController.text.trim(),
    "telegram_username": telegramController.text.trim(),

  };


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> updateSocialProfile(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try{
      final response = await authenticationRepo.updateSocialProfile(socialLinks);
      if(response['success'] == true){
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
            onPositivePressed: () async{
              final socialProvider = Provider.of<GetUserProfileProvider>(context, listen: false);
              final classProvider = context.read<ClassesProvider>();

              await socialProvider.fetchSocialProfile(context);

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
    } catch(e){
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



