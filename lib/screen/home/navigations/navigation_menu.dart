import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/authentication/get_user_profile_provider.dart';
import 'package:z_tutor_suganta/providers/support_screen/support_screen_provider.dart';
import 'package:z_tutor_suganta/screen/home/navigations/navigation_provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';

import '../../../providers/classes/classes_provider.dart';
import '../../../utils/helpers/user_sessions.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = LocalStorageService.getToken();
      if(token != null && token.isNotEmpty){
        final profileProvider = context.read<GetUserProfileProvider>();
        final ticketProvider = context.read<SupportScreenProvider>();
        final sessionProvider = context.read<UserSessionProvider>();
        final classProvider = context.read<ClassesProvider>();
        await classProvider.init(sessionProvider);
        classProvider.fetchProfilePercentage(context);
        final userRole = context.read<UserSessionProvider>().role?.toLowerCase();



        await profileProvider.fetchUserProfile(context);
         await profileProvider.fetchSocialProfile(context);
        await ticketProvider.init(sessionProvider);




        if (userRole == "teacher") {
          await profileProvider.fetchTeacherProfile(context);
        }

        if(userRole == 'institute' ||userRole == 'university' ){
          await profileProvider.fetchInstituteProfile(context);
        }


      }
    });

  }

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    final navigationProvider = context.watch<NavigationProvider>();
    return Scaffold(
      body: navigationProvider.currentScreen,
      bottomNavigationBar: CurvedNavigationBar(
          items: <Widget>[
            Icon(FontAwesomeIcons.solidClipboard, size: 30, color: AppColors.white,),
            Icon(FontAwesomeIcons.headset, size: 30,color: AppColors.white,),
            Icon(FontAwesomeIcons.solidCircleUser, size: 30,color: AppColors.white,),
          ],
        onTap: (index){
            navigationProvider.updateIndex(index);
        },
        height: 70,
        backgroundColor: Colors.transparent,
        color: dark ? AppColors.blue : AppColors.orange,
        buttonBackgroundColor: dark? AppColors.blue : AppColors.orange,

      ) ,
    );
  }
}
