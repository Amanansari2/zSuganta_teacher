import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/accounts/teaching_information_provider.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/utils/theme/theme_switcher_button.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';
import 'package:z_tutor_suganta/screen/accounts/teaching_information/widget/subject_selection_container.dart';

import '../../../models/accounts/options_model.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/user_sessions.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/texts/custom_text_form_field.dart';

class TeachingInformationScreen extends StatelessWidget {
  const TeachingInformationScreen({super.key});


  // @override
  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return ChangeNotifierProvider<TeachingInformationProvider>(
       create: (context){
         final provider = TeachingInformationProvider();
         provider.init(context.read<UserSessionProvider>());
         return provider;
       },
         child: Consumer<TeachingInformationProvider>(
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
                                 AppText.teachingInformation,
                                 style: Theme.of(context).textTheme.headlineMedium!
                                     .apply(color: AppColors.white),
                               ),
                             ),

                             SizedBox(
                               width: double.infinity,
                               child: Icon(
                                 FontAwesomeIcons.graduationCap,
                                 color: AppColors.white,
                                 size: 110,
                               ),
                             ),
                             SizedBox(height: Sizes.spaceBtwSections),
                           ],
                         )),

                     Expanded(
                         child: Padding(
                             padding: const EdgeInsets.all(Sizes.defaultSpace),
                         child: Form(
                             key: provider.formKey,
                             child: ListView(
                               children: [

                                 AppTextFiled(
                                   controller: provider.universityCollegeController,
                                   label: AppText.universityCollegeName,
                                   hint: AppText.enterUniversityCollegeName,
                                   isRequired: true,
                                   prefixIcon:  Icon(FontAwesomeIcons.university),
                                   validator:(value){
                                     if(value == null || value.trim().isEmpty){
                                       return "University/College name is required";
                                     }
                                     return null;
                                   } ,
                                 ),

                                 const SizedBox(height: Sizes.defaultSpace),

                                 AppTextFiled(
                                   controller: provider.graduationYearController,
                                   keyboardType: TextInputType.phone,
                                   label: AppText.graduationYear,
                                   hint: AppText.enterGraduationYear,
                                   isRequired: true,
                                   prefixIcon: Icon(FontAwesomeIcons.calendar),

                                   validator: (value){
                                     if(value == null || value.trim().isEmpty){
                                       return "Graduation year is required";
                                     }
                                     return null;
                                   },

                                 ),

                                 const SizedBox(height: Sizes.defaultSpace),


                                 Column(
                                   children: [
                                     Align(
                                       alignment: Alignment.topLeft,
                                       child: RichText(
                                         text: TextSpan(
                                           text: AppText.highestQualification,
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
                                       key: ValueKey(provider.selectedHighestQualification?.id),
                                       items: provider.highestQualification,
                                       selected: provider.selectedHighestQualification,
                                       onChanged: (val) {
                                        provider.setHighestQualification(val);
                                       },
                                       itemLabel: (item) => item.label,
                                       hint: AppText.selectHighestQualification,
                                       isLoading: provider.highestQualification.isEmpty && provider.isLoading,
                                       iconColor: dark ? AppColors.blue : AppColors.orange,
                                       textColor: dark ? AppColors.white: AppColors.black,
                                       validator: (value){
                                         if(value == null) return "Highest qualification is required";
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
                                           text: AppText.fieldOfStudy,
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
                                       key: ValueKey(provider.selectedFieldStudy?.id),
                                       items: provider.fieldStudy,
                                       selected: provider.selectedFieldStudy,
                                       onChanged: (val) {
                                         provider.setFieldStudy(val);
                                       },
                                       itemLabel: (item) => item.label,
                                       hint: AppText.selectFieldStudy,
                                       isLoading: provider.fieldStudy.isEmpty && provider.isLoading,
                                       iconColor: dark ? AppColors.blue : AppColors.orange,
                                       textColor: dark ? AppColors.white: AppColors.black,
                                       validator: (value){
                                         if(value == null) return "Field of study is required";
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
                                           text: AppText.teachingExperience,
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
                                       key: ValueKey(provider.selectedTeachingExperience?.id),
                                       items: provider.teachingExperience,
                                       selected: provider.selectedTeachingExperience,
                                       onChanged: (val) {
                                         provider.setTeachingExperience(val);
                                       },
                                       itemLabel: (item) => item.label,
                                       hint: AppText.selectTeachingExperience,
                                       isLoading: provider.teachingExperience.isEmpty && provider.isLoading,
                                       iconColor: dark ? AppColors.blue : AppColors.orange,
                                       textColor: dark ? AppColors.white: AppColors.black,
                                       validator: (value){
                                         if(value == null) return "Teaching experience is required";
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
                                           text: AppText.hourlyRateRange,
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
                                       key: ValueKey(provider.selectedHourlyRate?.id),
                                       items: provider.hourlyRate,
                                       selected: provider.selectedHourlyRate,
                                       onChanged: (val) {
                                         provider.setHourlyRate(val);
                                       },
                                       itemLabel: (item) => item.label,
                                       hint: AppText.selectHourlyRate,
                                       isLoading: provider.hourlyRate.isEmpty && provider.isLoading,
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
                                           text: AppText.monthlyRateRange,
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

                                     CustomDropdown<FilterOption>(
                                       key: ValueKey(provider.selectedMonthlyRate?.id),
                                       items: provider.monthlyRate,
                                       selected: provider.selectedMonthlyRate,
                                       onChanged: (val) {
                                         provider.setMonthlyRate(val);
                                       },
                                       itemLabel: (item) => item.label,
                                       hint: AppText.selectMonthlyRate,
                                       isLoading: provider.monthlyRate.isEmpty && provider.isLoading,
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
                                           text: AppText.travelRadius,
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
                                       key: ValueKey(provider.selectedTravelRadius?.id),
                                       items: provider.travelRadius,
                                       selected: provider.selectedTravelRadius,
                                       onChanged: (val) {
                                         provider.setTravelRadius(val);
                                       },
                                       itemLabel: (item) => item.label,
                                       hint: AppText.selectTravelRadius,
                                       isLoading: provider.travelRadius.isEmpty && provider.isLoading,
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
                                           text: AppText.teachingMode,
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
                                       key: ValueKey(provider.selectedTeachingMode?.id),
                                       items: provider.teachingMode,
                                       selected: provider.selectedTeachingMode,
                                       onChanged: (val) {
                                         provider.setTeachingMode(val);
                                       },
                                       itemLabel: (item) => item.label,
                                       hint: AppText.selectTeachingMode,
                                       isLoading: provider.teachingMode.isEmpty && provider.isLoading,
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
                                           text: AppText.availabilityStatus,
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
                                       key: ValueKey(provider.selectedAvailabilityStatus?.id),
                                       items: provider.availabilityStatus,
                                       selected: provider.selectedAvailabilityStatus,
                                       onChanged: (val) {
                                         provider.setAvailabilityStatus(val);
                                       },
                                       itemLabel: (item) => item.label,
                                       hint: AppText.selectAvailabilityStatus,
                                       isLoading: provider.availabilityStatus.isEmpty && provider.isLoading,
                                       iconColor: dark ? AppColors.blue : AppColors.orange,
                                       textColor: dark ? AppColors.white: AppColors.black,

                                     ),

                                   ],
                                 ),

                                 const SizedBox(height: Sizes.defaultSpace),

                                 SubjectsSelectionContainer(),
                                 const SizedBox(height: Sizes.defaultSpace),


                                 AppTextFiled(
                                   controller: provider.teachingPhilosophyController,
                                   label: AppText.teachingPhilosophy,
                                   hint: AppText.teachingApproachPhilosophy,
                                   isRequired: false,
                                   maxLines: 7,
                                 ),

                                 const SizedBox(height: Sizes.defaultSpace),


                                 Center(
                                   child: CustomButton(
                                     text: AppText.saveTeachingInfo,
                                     onPressed: (){
                                       if(!provider.isLoading){
                                         provider.updateTeacherInfo(context);
                                       }
                                     },
                                     color: dark? AppColors.blue : AppColors.orange,
                                     textColor: AppColors.white,
                                     radius: 15,
                                     fontSize: Sizes.md,
                                     width: 300,

                                   ),
                                 ),

                                 AppThemeSwitcherButton(),


                               ],
                             )
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










