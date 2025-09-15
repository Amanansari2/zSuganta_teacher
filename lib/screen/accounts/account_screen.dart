import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';
import 'package:z_tutor_suganta/utils/theme/theme_switcher_button.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';
import 'package:z_tutor_suganta/widgets/custom_app_bar.dart';
import 'package:z_tutor_suganta/widgets/list_tile/setting_menu_tile.dart';
import 'package:z_tutor_suganta/widgets/list_tile/user_profile_tile.dart';

import '../../utils/constants/sizes.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final userRole =context.watch<UserSessionProvider>().role.toLowerCase();

    return Scaffold(
      body: Column(
        children: [
          PrimaryHeaderContainer(
              child: Column(
                children: [

                  MyAppBar(
                    title: Text(
                      AppText.accounts,
                    style: Theme.of(context).textTheme.headlineLarge!.apply(color: AppColors.white),
                    ),
                  ),
                  const SizedBox(height: Sizes.defaultSpace),


                  UserProfileTile(
                      onPressed: (){
                        context.pushNamed('emailMobileScreen');
                      }
                  ),

                  const SizedBox(height: Sizes.spaceBtwSections),
                  const SizedBox(height: Sizes.defaultSpace),

                ],
              )
          ),

          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(Sizes.spaceBtwItems),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                    
                        SettingMenuTile(
                            icon: FontAwesomeIcons.userPen,
                            title: AppText.profile,
                            subTitle: AppText.updatePersonalDetails,
                            onTap: (){
                              context.pushNamed('updateProfileScreen');
                            },
                        ),
                    
                        SettingMenuTile(
                          icon: FontAwesomeIcons.shareNodes,
                          title: AppText.socialLinks,
                          subTitle: AppText.socialProfile,
                          onTap: (){
                            context.pushNamed('socialScreen');
                          },
                        ),

                        if(userRole == 'teacher')
                        SettingMenuTile(
                          icon: FontAwesomeIcons.graduationCap,
                          title: AppText.teachingInformation,
                          subTitle: AppText.subjectExperienceQualification,
                          onTap: (){
                            context.pushNamed('teachingInformationScreen');
                          },
                        ),

                        if(userRole == 'institute')
                        SettingMenuTile(
                          icon: FontAwesomeIcons.building,
                          title: AppText.instituteInformation,
                          subTitle: AppText.manageInstituteProfile,
                          onTap: (){
                            context.pushNamed('instituteInformationScreen');
                          },
                        ),

                        if(userRole == 'university')
                        SettingMenuTile(
                          icon: FontAwesomeIcons.handsHelping,
                          title: AppText.ngoInformation,
                          subTitle: AppText.manageNgoProfile,
                          onTap: (){},
                        ),

                        SettingMenuTile(
                          icon: FontAwesomeIcons.addressCard,
                          title: AppText.updateContact,
                          subTitle: AppText.editContactInformation,
                          onTap: (){
                            context.pushNamed('emailMobileScreen');
                          },
                        ),

                        SettingMenuTile(
                          icon: FontAwesomeIcons.shieldHalved,
                          title: AppText.resetPassword,
                          subTitle: AppText.newSecurePassword,
                          onTap: (){
                            context.pushNamed('resetPasswordScreen');
                          },
                        ),

                        SettingMenuTile(
                          icon: FontAwesomeIcons.userLock,
                          title: AppText.allSessions,
                          subTitle: AppText.seeDevicesLogged,
                          onTap: (){
                            context.pushNamed('sessionsScreen');
                          },
                        ),


            

                    
                        AppThemeSwitcherButton(),
                        SizedBox(height: Sizes.defaultSpace,),
                      ],
                    ),
                  ),
            ),
          )

        ],
      ),
    );
  }
}
