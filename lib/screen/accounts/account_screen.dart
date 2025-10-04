import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:z_tutor_suganta/providers/accounts/logout_provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/helpers/helper_function.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/utils/theme/theme_switcher_button.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';
import 'package:z_tutor_suganta/widgets/custom_app_bar.dart';
import 'package:z_tutor_suganta/widgets/custom_button.dart';
import 'package:z_tutor_suganta/widgets/list_tile/setting_menu_tile.dart';
import 'package:z_tutor_suganta/widgets/list_tile/user_profile_tile.dart';

import '../../utils/constants/sizes.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;

    final userRole =context.watch<UserSessionProvider>().role.toLowerCase();
    final logoutProvider = context.read<LogoutProvider>();

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
                          title: AppText.universityInformation,
                          subTitle: AppText.manageUniversityProfile,
                          onTap: (){
                            context.pushNamed('instituteInformationScreen');
                          },
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
                          icon: FontAwesomeIcons.ticket,
                          title: AppText.supportTickets,
                          subTitle: AppText.manageTrackTickets,
                          onTap: (){
                            context.pushNamed('supportTicketListScreen');
                          },
                        ),

                        SettingMenuTile(
                          icon: FontAwesomeIcons.chalkboardTeacher,
                          title: AppText.allClasses,
                          subTitle: AppText.manageTrackClasses,
                          onTap: (){
                            context.pushNamed('classListScreen');
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

                        SettingMenuTile(
                          icon: FontAwesomeIcons.fileContract,
                          title: AppText.termsCondition,
                          subTitle: AppText.knowYourRights,
                          onTap: ()async{
                            final uri = Uri.parse("https://www.suganta.com/terms-and-conditions");
                            if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                            }
                          },
                        ),

                        SettingMenuTile(
                          icon: FontAwesomeIcons.lock,
                          title: AppText.privacyPolicy,
                          subTitle: AppText.collectPersonalInformation,
                          onTap: ()async {
                            final uri = Uri.parse("https://www.suganta.com/privacy-and-policies");
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            }
                          },
                        ),

                        SettingMenuTile(
                            icon: FontAwesomeIcons.rightFromBracket,
                            title: AppText.logout,
                            subTitle: AppText.signOutFromYourAccount,
                        onTap: (){
                              showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  builder: (context){
                                    return SafeArea(
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: dark ? AppColors.black : AppColors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: dark ? AppColors.white : AppColors.black.withOpacity(0.7),
                                              blurRadius: 1,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(AppText.logout, style: Theme.of(context).textTheme.headlineLarge,),
                                            const SizedBox(height: Sizes.spaceBtwSections,),
                                            CustomButton(
                                                text: AppText.currentDevice,
                                                onPressed: ()async {
                                                  await logoutProvider.logoutFRomCurrentDevice(context);
                                                },
                                            color: dark ? AppColors.blue : AppColors.orange,
                                              width: HelperFunction.screenWidth(context),
                                            ),
                                            const SizedBox(height: Sizes.defaultSpace,),
                                      
                                            CustomButton(
                                              text: AppText.allDevices,
                                              onPressed: ()async{
                                                await logoutProvider.logoutFRomAllDevice(context);
                                              },
                                              color: dark ? AppColors.blue : AppColors.orange,
                                              width: HelperFunction.screenWidth(context),
                                            )
                                          ],
                                        ),
                                        ),
                                      ),
                                    );
                                  });
                        },
                        ),


            

                    

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
