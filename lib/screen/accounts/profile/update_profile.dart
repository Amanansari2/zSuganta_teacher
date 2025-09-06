import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/accounts/update_profile_provider.dart';
import 'package:z_tutor_suganta/utils/constants/image_strings.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';
import 'package:z_tutor_suganta/widgets/custom_app_bar.dart';
import 'package:z_tutor_suganta/widgets/images/circular_images.dart';
import 'package:z_tutor_suganta/widgets/texts/custom_text_form_field.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/theme/theme_switcher_button.dart';
import '../../../widgets/texts/date_text_form_field.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return ChangeNotifierProvider(
      create: (_) => UpdateProfileProvider(),
      child: Consumer<UpdateProfileProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Column(
              children: [
                PrimaryHeaderContainer(
                  child: Column(
                    children: [
                      MyAppBar(
                        showBackArrow: true,
                        title: Text(
                          AppText.updateProfile,
                          style: Theme.of(context).textTheme.headlineMedium!
                              .apply(color: AppColors.white),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            CircularImages(
                              image: AppImages.userIcon,
                              width: 100,
                              height: 100,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                AppText.changeProfileImage,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: AppColors.white),
                              ),
                            ),

                            SizedBox(height: Sizes.spaceBtwSections),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(Sizes.defaultSpace),
                      child: Form(
                        key: provider.formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: Sizes.spaceBtwItems),

                            AppTextFiled(
                              controller: provider.firstNameController,
                              label: AppText.firstName,
                              hint: AppText.enterFirstName,
                              isRequired: true,
                              prefixIcon: Icon(FontAwesomeIcons.user),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "First name is required";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: Sizes.defaultSpace),

                            AppTextFiled(
                              controller: provider.lastNameController,
                              label: AppText.lastName,
                              hint: AppText.enterLastName,
                              isRequired: true,
                              prefixIcon: Icon(FontAwesomeIcons.user),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Last name is required";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: Sizes.defaultSpace),

                            AppTextFiled(
                              controller: provider.displayNameController,
                              label: AppText.displayName,
                              hint: AppText.enterDisplayName,
                              isRequired: true,
                              prefixIcon: Icon(FontAwesomeIcons.user),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Display name is required";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: Sizes.defaultSpace),

                            AppTextFiled(
                              controller: provider.secondaryPhoneController,
                              keyboardType: TextInputType.phone,
                              label: AppText.secondaryPhoneNumber,
                              hint: AppText.enterSecondaryPhone,
                              prefixIcon: Icon(FontAwesomeIcons.phone),
                              isRequired: false,
                            ),

                            const SizedBox(height: Sizes.defaultSpace),

                            AppDatePickerField(
                              label: "Date of Birth",
                              hint: "Select your birth date",
                              controller: provider.dobController,
                              isRequired: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select your date of birth";
                                }
                                return null;
                              },
                              onChanged: (value) {},
                            ),

                            const SizedBox(height: Sizes.defaultSpace),

                            Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: AppText.gender,
                                  style: TextStyle(
                                    fontSize: Sizes.fontSizeLg,
                                    fontWeight: FontWeight.w600,
                                    color: dark ? AppColors.white : AppColors.black
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: Sizes.defaultSpace),
                            SizedBox(height: Sizes.defaultSpace),
                            SizedBox(height: Sizes.defaultSpace),
                            AppThemeSwitcherButton(),
                            SizedBox(height: Sizes.defaultSpace),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
