import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/utils/constants/image_strings.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';
import 'package:z_tutor_suganta/widgets/images/circular_images.dart';

import '../../configs/url.dart';
import '../../utils/constants/app_colors.dart';

class UserProfileTile extends StatelessWidget {
 final VoidCallback onPressed;
  const UserProfileTile({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<GetUserProfileProvider>();
    final provider = context.watch<UserSessionProvider>();

    final user = provider.currentUser;

    
    if(user == null){
      return const ListTile(
        leading: CircleAvatar(child: Icon(FontAwesomeIcons.user),),
        title: Text('Guest User'),
        subtitle: Text('No email available'),
      );
    }
    
    final bool hasProfileImage = user.profileImage != null && user.profileImage!.isNotEmpty;

    if (hasProfileImage) {
      final profileImageUrl = "${ApiUrls.mediaUrl}${user.profileImage!}";
      LoggerHelper.info("Profile Image Url -->> $profileImageUrl");
    }


    return ListTile(
      leading:  CircularImages(
          width: 80,
          height: 80,
          padding: 0,
        fallbackAsset: AppImages.userIcon,
        image: hasProfileImage
            ? user.profileImage!
            : null,
      ),
      title: Text("${user.firstName} ${user.lastName}", style: Theme.of(context).textTheme.headlineMedium!.apply(color: AppColors.white),),
      subtitle: Text(user.email, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white, fontWeight: FontWeight.w700 ),),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(FontAwesomeIcons.edit, color: AppColors.white,),),
    );
  }
}
