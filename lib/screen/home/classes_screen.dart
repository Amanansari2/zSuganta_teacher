import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/models/accounts/options_model.dart';
import 'package:z_tutor_suganta/providers/classes/classes_provider.dart';
import 'package:z_tutor_suganta/screen/home/widgets/icon_widgets.dart';
import 'package:z_tutor_suganta/screen/home/widgets/percentage_bar.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';
import 'package:z_tutor_suganta/widgets/custom_app_bar.dart';

import '../../utils/constants/text_strings.dart';
import '../../utils/theme/theme_switcher_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/texts/custom_text_form_field.dart';
import '../../widgets/texts/date_text_form_field.dart';
import '../../widgets/texts/time_text_form_field.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ClassesProvider>();
      provider.fetchProfilePercentage(context);
      provider.init(context.read<UserSessionProvider>());
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    final provider = context.read<ClassesProvider>();
    final userProvider = context.watch<UserSessionProvider>();
    final userRole = userProvider.role.toLowerCase();
    final user = userProvider.currentUser;
    return Scaffold(
      body: Column(
        children: [
          PrimaryHeaderContainer(
            child: Column(
              children: [
                MyAppBar(
                  showBackArrow: false,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.welcomeBack,
                        style: Theme.of(context).textTheme.headlineSmall!.apply(
                          color: AppColors.white,
                        ),
                      ),

                      Text(
                        "${user?.firstName} ${user?.lastName}",
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.apply(color: AppColors.white),
                      ),
                      Text(
                        "${user?.email}",
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.apply(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Sizes.spaceBtwSections),
                SizedBox(height: Sizes.defaultSpace),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.spaceBtwItems,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const ProfileCompletionBar(),

                    Divider(
                      color: dark
                          ? AppColors.white.withOpacity(0.6)
                          : AppColors.black.withOpacity(0.6),
                    ),
                    SizedBox(height: Sizes.defaultSpace),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        containerWithIconRoute(
                          context: context,
                          icon: FontAwesomeIcons.ticket,
                          title: AppText.tickets,
                          subTitle: AppText.manageTrackTickets,
                          buttonText: AppText.viewTickets,
                          onPressed: () {
                            context.pushNamed('supportTicketListScreen');
                          },
                        ),

                        containerWithIconRoute(
                          context: context,
                          icon: FontAwesomeIcons.userLock,
                          title: AppText.sessions,
                          subTitle: AppText.seeDevicesLogged,
                          buttonText: AppText.viewSessions,
                          onPressed: () {
                            context.pushNamed('sessionsScreen');
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: Sizes.defaultSpace),


                        containerWithIconRoute(
                          context: context,
                          icon: FontAwesomeIcons.chalkboardTeacher,
                          title: AppText.classes,
                          subTitle: AppText.manageClasses,
                          buttonText: AppText.viewClasses,
                          onPressed: () {
                            context.pushNamed('classListScreen');
                          },
                        ),






                    Divider(
                      color: dark
                          ? AppColors.white.withOpacity(0.6)
                          : AppColors.black.withOpacity(0.6),
                    ),
                    SizedBox(height: Sizes.defaultSpace),




                    Container(
                      margin: EdgeInsets.all(1),
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
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.sm, vertical: Sizes.defaultSpace),
                        child: Form(
                          key: provider.formKey,
                            child: Column(
                              children: [

                                Text(
                                  AppText.createNewClasses,
                                  style: Theme.of(context).textTheme.headlineLarge,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Sizes.spaceBtwSections, vertical: Sizes.sm),
                                  child: Divider(
                                    thickness: 2,
                                    color: dark
                                        ? AppColors.white.withOpacity(0.6)
                                        : AppColors.black.withOpacity(0.6),
                                  ),
                                ),

                                if(userRole!= 'teacher')
                                Column(
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
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: Sizes.spaceBtwItems),

                                    CustomDropdown<FilterOption>(
                                      key: ValueKey(provider.selectedTeacher?.id),
                                      items: provider.teachers,
                                      selected: provider.selectedTeacher,
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

                                    CustomDropdown<FilterOption>(
                                      key: ValueKey(provider.selectedExamCategory?.id),
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
                                    if (value == null || value.trim().isEmpty) {
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
                                  onChanged: (value) {},
                                  validator: (value){
                                    if (value == null || value.trim().isEmpty) {
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
                                  validator: (value){
                                    if (value == null || value.trim().isEmpty) {
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
                                    if (value == null || value.trim().isEmpty) {
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
                                    if (value == null || value.trim().isEmpty) {
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
                                  prefixIcon: Icon(FontAwesomeIcons.indianRupeeSign),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
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
                                    text: AppText.createClass,
                                    onPressed: (){
                                        if(!provider.isLoading){
                                        provider.createClasses(context);
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
                            )),
                      ),
                    ),



                    Divider(
                      color: dark
                          ? AppColors.white.withOpacity(0.6)
                          : AppColors.black.withOpacity(0.6),
                    ),
                    SizedBox(height: Sizes.defaultSpace),

                    sessionGuideLines(context),

                    SizedBox(height: Sizes.defaultSpace),

                    tipsForSuccess(context),

                    SizedBox(height: Sizes.defaultSpace),

                     importantNotes(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




