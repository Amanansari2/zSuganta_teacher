import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/models/classes/class_detailed_model.dart';
import 'package:z_tutor_suganta/providers/classes/edit_class_provider.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';

import '../../../models/accounts/options_model.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/user_sessions.dart';
import '../../../utils/theme/provider/theme_provider.dart';
import '../../../widgets/containers/primary_header_container.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/texts/custom_text_form_field.dart';
import '../../../widgets/texts/date_text_form_field.dart';
import '../../../widgets/texts/time_text_form_field.dart';

class EditClassScreen extends StatelessWidget {
  final ClassDetailedModel classDetails;

  const EditClassScreen({super.key, required this.classDetails});


  @override
  Widget build(BuildContext context) {
    final dark = context
        .watch<ThemeProvider>()
        .isDarkMode;

    final userRole = context.watch<UserSessionProvider>().role.toLowerCase();


    return ChangeNotifierProvider(
      create: (context) {
        final provider = EditClassProvider();
        provider.init(context.read<UserSessionProvider>(), classDetails);
        return provider;
    },
        child:  Consumer<EditClassProvider>(
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
                            AppText.editClassDetails,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                              color: AppColors.white,
                            ),
                          ),

                        ),
                        SizedBox(height: Sizes.defaultSpace),
                      ],
                    ),
                  ),

                  Expanded(
                      child: SingleChildScrollView(
                          child:
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.sm, vertical: Sizes.defaultSpace),
                            child: Form(
                                key: provider.formKey,
                                child: Column(
                                  children: [
                                    userRole == 'teacher'
                                     ? SizedBox.shrink()
                                    : Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                  text: AppText.teachers,
                                                  style: TextStyle(
                                                    fontSize: Sizes.fontSizeLg,
                                                    fontWeight: FontWeight.w600,
                                                    color: dark
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: ' *',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                                height: Sizes.spaceBtwItems),

                                            CustomDropdown<FilterOption>(
                                              key: ValueKey(
                                                  provider.selectedTeacher?.id),
                                              items: provider.teachers,
                                              selected: provider
                                                  .selectedTeacher,
                                              onChanged: (val) {
                                                provider.setTeacher(val);
                                              },
                                              itemLabel: (item) => item.label,
                                              hint: AppText.selectTeacher,
                                              isLoading:
                                              provider.teachers.isEmpty &&
                                                  provider.isLoading,
                                              iconColor: dark
                                                  ? AppColors.blue
                                                  : AppColors.orange,
                                              textColor: dark
                                                  ? AppColors.white
                                                  : AppColors.black,
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Teachers is required";
                                                }
                                                return null;
                                              },

                                            ),
                                          ],
                                        ),




                                    SizedBox(height: Sizes.iconXs,),

                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                            text: TextSpan(
                                              text: AppText.subject,
                                              style: TextStyle(
                                                fontSize: Sizes.fontSizeLg,
                                                fontWeight: FontWeight.w600,
                                                color: dark
                                                    ? AppColors.white
                                                    : AppColors.black,
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
                                          key: ValueKey(provider.selectedSubject?.id),
                                          items: provider.subjects,
                                          selected: provider.selectedSubject,
                                          onChanged: (val) {
                                            provider.setSubject(val);
                                          },
                                          itemLabel: (item) => item.label,
                                          hint: AppText.selectSubject,
                                          isLoading:
                                          provider.subjects.isEmpty &&
                                              provider.isLoading,
                                          iconColor: dark
                                              ? AppColors.blue
                                              : AppColors.orange,
                                          textColor: dark
                                              ? AppColors.white
                                              : AppColors.black,
                                          validator: (value) {
                                            if (value == null) {
                                              return "Subject is required";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: Sizes.iconXs,),

                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                            text: TextSpan(
                                              text: AppText.exam,
                                              style: TextStyle(
                                                fontSize: Sizes.fontSizeLg,
                                                fontWeight: FontWeight.w600,
                                                color: dark
                                                    ? AppColors.white
                                                    : AppColors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: '', //' *',
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
                                          key: ValueKey(provider.selectedExam?.id),
                                          items: provider.exam,
                                          selected: provider.selectedExam,
                                          onChanged: (val) {
                                            provider.setExam(val);
                                          },
                                          itemLabel: (item) => item.label,
                                          hint: AppText.selectExam,
                                          isLoading:
                                          provider.exam.isEmpty &&
                                              provider.isLoading,
                                          iconColor: dark
                                              ? AppColors.blue
                                              : AppColors.orange,
                                          textColor: dark
                                              ? AppColors.white
                                              : AppColors.black,
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: Sizes.iconXs,),

                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                            text: TextSpan(
                                              text: AppText.examCategory,
                                              style: TextStyle(
                                                fontSize: Sizes.fontSizeLg,
                                                fontWeight: FontWeight.w600,
                                                color: dark
                                                    ? AppColors.white
                                                    : AppColors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: '', //' *',
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
                                          key: ValueKey(
                                              provider.selectedExamCategory?.id),
                                          items: provider.examCategories,
                                          selected: provider.selectedExamCategory,
                                          onChanged: (val) {
                                            provider.setExamCategory(val);
                                          },
                                          itemLabel: (item) => item.label,
                                          hint: AppText.priorityLevel,
                                          isLoading:
                                          provider.examCategories.isEmpty &&
                                              provider.isLoading,
                                          iconColor: dark
                                              ? AppColors.blue
                                              : AppColors.orange,
                                          textColor: dark
                                              ? AppColors.white
                                              : AppColors.black,
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: Sizes.iconXs,),

                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                            text: TextSpan(
                                              text: AppText.classType,
                                              style: TextStyle(
                                                fontSize: Sizes.fontSizeLg,
                                                fontWeight: FontWeight.w600,
                                                color: dark
                                                    ? AppColors.white
                                                    : AppColors.black,
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

                                        CustomDropdown<TicketOptions>(
                                          key: ValueKey(provider.selectedType?.id),
                                          items: provider.type,
                                          selected: provider.selectedType,
                                          onChanged: (val) {
                                            provider.setType(val);
                                          },
                                          itemLabel: (item) => item.label,
                                          hint: AppText.selectClassType,
                                          isLoading:
                                          provider.type.isEmpty &&
                                              provider.isLoading,
                                          iconColor: dark
                                              ? AppColors.blue
                                              : AppColors.orange,
                                          textColor: dark
                                              ? AppColors.white
                                              : AppColors.black,
                                          validator: (value) {
                                            if (value == null) {
                                              return "Class type is required";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),


                                    SizedBox(height: Sizes.iconXs,),

                                    AppTextFiled(
                                      controller: provider.classTitleController,
                                      label: AppText.classTitle,
                                      hint: AppText.enterClassTitle,
                                      isRequired: true,
                                      prefixIcon: Icon(FontAwesomeIcons.bookOpenReader),
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "Class title is required";
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: Sizes.iconXs,),

                                    AppTextFiled(
                                      controller: provider.descriptionController,
                                      label: AppText.description,
                                      hint: AppText.enterClassDescription,
                                      isRequired: false,
                                      maxLines: 7,
                                    ),

                                    SizedBox(height: Sizes.iconXs,),

                                    AppDatePickerField(
                                      isRequired: true,
                                      label: "Date",
                                      hint: "Select Date",
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2040),
                                      controller: provider.dateController,
                                      onChanged: (value) {
                                        // provider.dateChanged = true;
                                      },
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "Date is required";
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: Sizes.iconXs,),

                                    AppTimePickerField(
                                      label: "Select Time",
                                      hint: "Choose a time",
                                      controller: provider.timeController,
                                      isRequired: true,
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "Time is required";
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: Sizes.iconXs,),

                                    AppTextFiled(
                                      keyboardType: TextInputType.phone,
                                      controller: provider.durationController,
                                      label: AppText.duration,
                                      hint: AppText.enterDuration,
                                      isRequired: true,
                                      prefixIcon: Icon(FontAwesomeIcons.clock),
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "Class duration is required";
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: Sizes.iconXs,),

                                    AppTextFiled(
                                      keyboardType: TextInputType.phone,
                                      controller: provider.maxStudentsController,
                                      label: AppText.maxStudents,
                                      hint: AppText.enterMaxStudents,
                                      isRequired: true,
                                      prefixIcon: Icon(FontAwesomeIcons.peopleGroup),
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "Maximum students is required";
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: Sizes.iconXs,),

                                    AppTextFiled(
                                      keyboardType: TextInputType.phone,
                                      controller: provider.priceController,
                                      label: AppText.price,
                                      hint: AppText.enterPrice,
                                      isRequired: true,
                                      prefixIcon: Icon(
                                          FontAwesomeIcons.indianRupeeSign),
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "Price is required";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: Sizes.iconXs,),

                                    AppTextFiled(
                                      controller: provider.locationController,
                                      label: AppText.locationMeetingLink,
                                      hint: AppText.physicalMeetingLink,
                                      isRequired: false,
                                      prefixIcon: Icon(FontAwesomeIcons.meetup),
                                    ),

                                    SizedBox(height: Sizes.iconXs,),

                                    Center(
                                      child: CustomButton(
                                        text: AppText.editClassDetails,
                                        onPressed: () {
                                          if (!provider.isLoading) {
                                             provider.editClass(classId: classDetails.id,context);
                                          }
                                        },
                                        color: dark ? AppColors.blue : AppColors.orange,
                                        textColor: AppColors.white,
                                        radius: 15,
                                        fontSize: Sizes.md,
                                        width: 300,

                                      ),
                                    ),

                                    SizedBox(height: Sizes.spaceBtwSections,),

                                  ],
                                )),
                          )

                      ))

                ],
              ),
            );
          }
        )
    );
  }
}
