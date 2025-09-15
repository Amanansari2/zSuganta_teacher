import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/accounts/institute_information_provider.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';
import 'package:z_tutor_suganta/widgets/custom_button.dart';

import '../../../models/accounts/options_model.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/theme/provider/theme_provider.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/texts/custom_text_form_field.dart';

class InstituteInformationScreen extends StatelessWidget {
  const InstituteInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return ChangeNotifierProvider<InstituteInformationProvider>(
      create: (context) {
        final provider = InstituteInformationProvider();
        provider.init(context.read<UserSessionProvider>());
        return provider;
      },
      child: Consumer<InstituteInformationProvider>(
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
                              AppText.instituteInformation,
                              style: Theme.of(context).textTheme.headlineMedium!
                                  .apply(color: AppColors.white),
                            ),
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: Icon(
                              FontAwesomeIcons.building,
                              color: AppColors.white,
                              size: 110,
                            ),
                          ),

                          SizedBox(height: Sizes.spaceBtwSections),

                        ],

                    ),
                ),

                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(Sizes.defaultSpace),
                      child: Form(
                          key: provider.formKey,
                          child: ListView(
                            children: [
                              AppTextFiled(
                                controller: provider.instituteNameController,
                                label: AppText.instituteName,
                                hint: AppText.enterInstituteName,
                                isRequired: true,
                                prefixIcon:  Icon(FontAwesomeIcons.university),
                                validator:(value){
                                  if(value == null || value.trim().isEmpty){
                                    return "Institute name is required";
                                  }
                                  return null;
                                } ,
                              ),

                              const SizedBox(height: Sizes.defaultSpace),

                              AppTextFiled(
                                controller: provider.principalNameController,
                                label: AppText.principalDirectorName,
                                hint: AppText.enterPrincipalDirectorName,
                                isRequired: true,
                                prefixIcon:  Icon(FontAwesomeIcons.user),
                              ),

                              const SizedBox(height: Sizes.defaultSpace),

                              AppTextFiled(
                                controller: provider.principalPhoneController,
                                label: AppText.principalPhone,
                                hint: AppText.enterPhone,
                                isRequired: true,
                                prefixIcon:  Icon(FontAwesomeIcons.user),
                              ),

                              const SizedBox(height: Sizes.defaultSpace),

                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        text: AppText.instituteType,
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

                                  const SizedBox(height: Sizes.spaceBtwItems),

                                  CustomDropdown<FilterOption>(
                                    key: ValueKey(provider.selectedInstituteType?.id),
                                    items: provider.instituteType,
                                    selected: provider.selectedInstituteType,
                                    onChanged: (val) {
                                      provider.setInstituteType(val);
                                    },
                                    itemLabel: (item) => item.label,
                                    hint: AppText.selectInstituteType,
                                    isLoading: provider.instituteType.isEmpty && provider.isLoading,
                                    iconColor: dark ? AppColors.blue : AppColors.orange,
                                    textColor: dark ? AppColors.white: AppColors.black,
                                    validator: (value){
                                      if(value == null) return "Institute type is required";
                                      return null;
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: Sizes.defaultSpace),

                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        text: AppText.category,
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

                                  const SizedBox(height: Sizes.spaceBtwItems),

                                  CustomDropdown<FilterOption>(
                                    key: ValueKey(provider.selectedInstituteCategory?.id),
                                    items: provider.instituteCategory,
                                    selected: provider.selectedInstituteCategory,
                                    onChanged: (val) {
                                      provider.setInstituteCategory(val);
                                    },
                                    itemLabel: (item) => item.label,
                                    hint: AppText.selectCategory,
                                    isLoading: provider.instituteCategory.isEmpty && provider.isLoading,
                                    iconColor: dark ? AppColors.blue : AppColors.orange,
                                    textColor: dark ? AppColors.white: AppColors.black,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            text: AppText.establishmentYearRange,
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

                                      const SizedBox(height: Sizes.spaceBtwItems),

                                      CustomDropdown<FilterOption>(
                                        key: ValueKey(provider.selectedEstablishmentYear?.id),
                                        items: provider.establishmentYear,
                                        selected: provider.selectedEstablishmentYear,
                                        onChanged: (val) {
                                          provider.setEstablishmentYear(val);
                                        },
                                        itemLabel: (item) => item.label,
                                        hint: AppText.selectEstablishmentYearRange,
                                        isLoading: provider.establishmentYear.isEmpty && provider.isLoading,
                                        iconColor: dark ? AppColors.blue : AppColors.orange,
                                        textColor: dark ? AppColors.white: AppColors.black,

                                      ),

                                    ],
                                  ),


                                  const SizedBox(height: Sizes.defaultSpace),


                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            text: AppText.totalStudentRange,
                                            style: TextStyle(
                                                fontSize: Sizes.fontSizeLg,
                                                fontWeight: FontWeight.w600,
                                                color: dark ? AppColors.white : AppColors.black
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '',//' *',,
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

                                      CustomDropdown<FilterOption>(
                                        key: ValueKey(provider.selectedTotalStudents?.id),
                                        items: provider.totalStudent,
                                        selected: provider.selectedTotalStudents,
                                        onChanged: (val) {
                                          provider.setTotalStudents(val);
                                        },
                                        itemLabel: (item) => item.label,
                                        hint: AppText.selectStudentRange,
                                        isLoading: provider.totalStudent.isEmpty && provider.isLoading,
                                        iconColor: dark ? AppColors.blue : AppColors.orange,
                                        textColor: dark ? AppColors.white: AppColors.black,

                                      ),

                                    ],
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),


                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            text: AppText.totalTeacherRange,
                                            style: TextStyle(
                                                fontSize: Sizes.fontSizeLg,
                                                fontWeight: FontWeight.w600,
                                                color: dark ? AppColors.white : AppColors.black
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '',//' *',,
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

                                      CustomDropdown<FilterOption>(
                                        key: ValueKey(provider.selectedTotalTeacher?.id),
                                        items: provider.totalTeacher,
                                        selected: provider.selectedTotalTeacher,
                                        onChanged: (val) {
                                          provider.setTotalTeacher(val);
                                        },
                                        itemLabel: (item) => item.label,
                                        hint: AppText.selectTeacherRange,
                                        isLoading: provider.totalTeacher.isEmpty && provider.isLoading,
                                        iconColor: dark ? AppColors.blue : AppColors.orange,
                                        textColor: dark ? AppColors.white: AppColors.black,

                                      ),

                                    ],
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  AppTextFiled(
                                    controller: provider.instituteDescriptionController,
                                    label: AppText.instituteDescription,
                                    hint: AppText.describeYourInstitute,
                                    isRequired: false,
                                    maxLines: 7,
                                  ),

                                  const SizedBox(height:  Sizes.defaultSpace,),

                                  Center(
                                    child: CustomButton(
                                        text: AppText.saveInstituteInfo,
                                        onPressed: (){
                                          if(!provider.isLoading){
                                            provider.updateInstituteInfo(context);
                                          }
                                        },
                                    color: dark ? AppColors.blue : AppColors.orange,
                                    textColor:  AppColors.white,
                                    radius: 15,
                                    fontSize: Sizes.md,
                                    width: 300,
                                    ),
                                  )


                                ],
                              ),
                            ],
                          )),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
