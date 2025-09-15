import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/accounts/update_profile_provider.dart';
import 'package:z_tutor_suganta/utils/constants/image_strings.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/widgets/chips/choice_chip.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';
import 'package:z_tutor_suganta/widgets/custom_app_bar.dart';
import 'package:z_tutor_suganta/widgets/custom_button.dart';
import 'package:z_tutor_suganta/widgets/images/circular_images.dart';
import 'package:z_tutor_suganta/widgets/texts/custom_text_form_field.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/services/local_storage_service.dart';
import '../../../widgets/texts/date_text_form_field.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    final currentUser = LocalStorageService.getUser();
    return ChangeNotifierProvider(
      create: (_) {
        final provider = UpdateProfileProvider();
        final currentUser = LocalStorageService.getUser();
        if (currentUser != null) {
          provider.firstNameController.text = currentUser.firstName;
          provider.lastNameController.text = currentUser.lastName;
          provider.displayNameController.text = currentUser.displayName ?? '';
          provider.secondaryPhoneController.text = currentUser.secondaryNumber ?? '';
          provider.dobController.text = currentUser.dateOfBirth ?? '';
          provider.addressController.text = currentUser.address ?? '';
          provider.areaController.text = currentUser.area ?? '';
          provider.cityController.text = currentUser.city ?? '';
          provider.stateController.text = currentUser.state ?? '';
          provider.zipController.text = currentUser.pinCode?.toString() ?? '';
          provider.bioController.text = currentUser.bio ?? '';
           provider.setGender(currentUser.gender);
          provider.profileImage = currentUser.profileImage != null
              ? File(currentUser.profileImage!)
              : null;
        }
        return provider;
      },
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
                            Stack(
                              children: [
                                CircularImages(
                                  image:provider.profileImage?.path ?? currentUser?.profileImage,
                                  fallbackAsset: AppImages.userIcon,
                                  width: 100,
                                  height: 100,
                                ),

                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () async {
                                        await provider.pickProfileImage(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: AppColors.white, width: 2),
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        child: const Icon(
                                          FontAwesomeIcons.edit,
                                          color: AppColors.black,
                                          size: 18,
                                        ),
                                      ),
                                    ))
                              ],
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
                              onChanged: (value) {},
                            ),

                            const SizedBox(height: Sizes.defaultSpace),

                            Column(
                              children: [
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
                                          text: '',//' *',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: Sizes.spaceBtwItems),

                                 Wrap(
                                      spacing: 5,
                                      runSpacing: 8,
                                      children: provider.genderOptions.entries.map((entry) {
                                        return MyChoiceChip(
                                          text: entry.value,
                                          selected: provider.gender == entry.key,
                                          onSelected: (_) => provider.setGender(entry.key),
                                        );
                                      }).toList(),
                                    ),
                              ],
                            ),

                            const SizedBox(height: Sizes.defaultSpace),

                            AppTextFiled(
                              controller: provider.addressController,
                              label: AppText.address,
                              hint: AppText.enterAddress,
                              maxLines: 3,
                              prefixIcon: Icon(FontAwesomeIcons.building),
                            ),


                            const SizedBox(height: Sizes.defaultSpace),

                            AppTextFiled(
                              controller: provider.areaController,
                              label: AppText.area,
                              hint: AppText.enterArea,
                              prefixIcon: Icon(FontAwesomeIcons.building),
                            ),

                            const SizedBox(height: Sizes.defaultSpace),

                            AppTextFiled(
                              controller: provider.cityController,
                              label: AppText.city,
                              hint: AppText.enterCity,
                              prefixIcon: Icon(FontAwesomeIcons.building),
                            ),

                            const SizedBox(height: Sizes.defaultSpace),

                            AppTextFiled(
                              controller: provider.stateController,
                              label: AppText.state,
                              hint: AppText.enterState,
                              prefixIcon: Icon(FontAwesomeIcons.building),

                            ),

                            const SizedBox(height: Sizes.defaultSpace),

                            AppTextFiled(
                              keyboardType: TextInputType.phone,
                              controller: provider.zipController,
                              label: AppText.pinCode,
                              hint: AppText.enterPin,
                              prefixIcon: Icon(FontAwesomeIcons.mapPin),
                            ),

                            const SizedBox(height: Sizes.defaultSpace),

                            AppTextFiled(
                              controller: provider.bioController,
                              label: AppText.description,
                              hint: AppText.enterDescription,
                              maxLines: 7,

                            ),

                            SizedBox(height: Sizes.defaultSpace),


                            Center(
                              child: CustomButton(
                                  text: AppText.updateProfile,
                                  onPressed: (){
                                    if(!provider.isLoading){
                                      provider.updateProfile(context);
                                    }
                                  },
                                  color: dark? AppColors.blue : AppColors.orange,
                                  textColor: AppColors.white,
                                  radius: 15,
                                  fontSize: Sizes.md,
                                  width: 300,

                              ),
                            ),

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
