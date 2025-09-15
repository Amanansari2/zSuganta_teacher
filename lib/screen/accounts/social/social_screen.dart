import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/accounts/social_link_provider.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';
import 'package:z_tutor_suganta/widgets/custom_button.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/theme/provider/theme_provider.dart';
import '../../../utils/theme/theme_switcher_button.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/texts/custom_text_form_field.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return ChangeNotifierProvider(
        create: (_) {
          final provider = SocialLinkProvider();
          final currentProfile = LocalStorageService.getSocial();
          if(currentProfile != null){
            provider.facebookController.text = currentProfile.facebookUrl ?? '';
            provider.twitterController.text = currentProfile.twitterUrl ?? '';
            provider.instagramController.text = currentProfile.instagramUrl ?? '';
            provider.linkedinController.text = currentProfile.linkedinUrl ?? '';
            provider.youtubeController.text = currentProfile.youtubeUrl ?? '';
            provider.websiteController.text = currentProfile.websiteUrl ?? '';
            provider.whatsappController.text = currentProfile.whatsappNumber ?? '';
            provider.telegramController.text = currentProfile.telegramUrl ?? '';
          }
          return provider;
        },
      child: Consumer<SocialLinkProvider>(
          builder: (context, provider, child){
          return Scaffold(
            body: Column(
              children: [
                PrimaryHeaderContainer(
                    child: Column(
                      children: [
                        MyAppBar(
                          showBackArrow: true,
                          title: Text(
                            AppText.updateSocial,
                            style: Theme.of(context).textTheme.headlineMedium!
                                .apply(color: AppColors.white),
                          ),
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: Icon(
                            FontAwesomeIcons.shareNodes,
                            color: AppColors.white,
                            size: 110,
                          ),
                        ),
                        SizedBox(height: Sizes.spaceBtwSections),

                      ],
                    )
                ),

                Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(Sizes.defaultSpace),
                          child: Form(
                              key: provider.formKey,
                              child: Column(
                                children: [
                                  AppTextFiled(
                                    controller: provider.facebookController,
                                    label: AppText.facebookUrl,
                                    hint: AppText.enterFacebookUrl,
                                    prefixIcon: Icon(FontAwesomeIcons.facebook),
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  AppTextFiled(
                                    controller: provider.twitterController,
                                    label: AppText.twitterUrl,
                                    hint: AppText.enterTwitterUrl,
                                    prefixIcon: Icon(FontAwesomeIcons.twitter),
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  AppTextFiled(
                                    controller: provider.instagramController,
                                    label: AppText.instagramUrl,
                                    hint: AppText.enterInstagramUrl,
                                    prefixIcon: Icon(FontAwesomeIcons.instagram),
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  AppTextFiled(
                                    controller: provider.linkedinController,
                                    label: AppText.linkedinUrl,
                                    hint: AppText.enterLinkedinUrl,
                                    prefixIcon: Icon(FontAwesomeIcons.linkedinIn),
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  AppTextFiled(
                                    controller: provider.youtubeController,
                                    label: AppText.youtubeUrl,
                                    hint: AppText.enterYoutubeUrl,
                                    prefixIcon: Icon(FontAwesomeIcons.youtube),
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  AppTextFiled(
                                    controller: provider.websiteController,
                                    label: AppText.websiteUrl,
                                    hint: AppText.enterWebsiteUrl,
                                    prefixIcon: Icon(FontAwesomeIcons.link),
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  AppTextFiled(
                                    keyboardType: TextInputType.phone,
                                    controller: provider.whatsappController,
                                    label: AppText.whatsappNumber,
                                    hint: AppText.enterWhatsappNumber,
                                    prefixIcon: Icon(FontAwesomeIcons.whatsapp),
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  AppTextFiled(
                                    controller: provider.telegramController,
                                    label: AppText.telegramName,
                                    hint: AppText.enterTelegramName,
                                    prefixIcon: Icon(FontAwesomeIcons.telegram),
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  Center(
                                    child: CustomButton(
                                      text: AppText.saveSocialProfile,
                                      onPressed: (){
                                        if(!provider.isLoading){
                                          provider.updateSocialProfile(context);
                                        }
                                      },
                                      color: dark? AppColors.blue : AppColors.orange,
                                      textColor: AppColors.white,
                                      radius: 15,
                                      fontSize: Sizes.md,
                                      width: 300,
                                    ),
                                  ),

                                  SizedBox(height: Sizes.defaultSpace),
                                  SizedBox(height: Sizes.defaultSpace),
                                  SizedBox(height: Sizes.defaultSpace),
                                  AppThemeSwitcherButton(),
                                  SizedBox(height: Sizes.defaultSpace),
                                ],
                              )),
                          ),
                    ))
              ],
            ),
          );
          }
          ),

    );
  }
}
