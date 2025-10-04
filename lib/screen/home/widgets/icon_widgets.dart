import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/theme/provider/theme_provider.dart';
import '../../../widgets/custom_button.dart';

Widget containerWithIconRoute({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String subTitle,
  required String buttonText,
  required VoidCallback onPressed
}) {
  final dark = context.watch<ThemeProvider>().isDarkMode;
  return Container(
    width: 160,
    height: 290,
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
      padding: const EdgeInsets.all(Sizes.sm),
      child: Column(children: [
        Icon(icon, color: dark ? AppColors.blue : AppColors.orange, size: 70,),
        SizedBox(height: Sizes.spaceBtwSections,),
        Text(title,
          style: Theme.of(context).textTheme.headlineMedium,),
        SizedBox(height: Sizes.xs,),
        Text(subTitle,
          style: Theme.of(context).textTheme.bodyLarge,),
        SizedBox(height: Sizes.defaultSpace,),
        CustomButton(
          fontSize: 10,
          text: buttonText, onPressed:onPressed,
          color: dark ? AppColors.blue : AppColors.orange,
        )
      ]),
    ),
  );
}

Widget sessionGuideLines(BuildContext context){
  final dark = context.watch<ThemeProvider>().isDarkMode;
 return Container(
    margin: EdgeInsets.all(Sizes.sm),
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
      padding: const EdgeInsets.all(Sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.classesGuideLines,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Divider(color: dark? AppColors.white.withOpacity(0.6) : AppColors.black.withOpacity(0.6),),
          SizedBox(height: Sizes.defaultSpace,),
          Row(
            children: [
              Icon(FontAwesomeIcons.circleCheck, color: AppColors.green,size: 20,),
              SizedBox(width: Sizes.md,),
              Expanded(
                child: Text(AppText.minimumDuration,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
          SizedBox(height: Sizes.defaultSpace,),
          Row(
            children: [
              Icon(FontAwesomeIcons.circleCheck, color: AppColors.green,size: 20,),
              SizedBox(width: Sizes.md,),
              Expanded(
                child: Text(AppText.maximumDuration,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
          SizedBox(height: Sizes.defaultSpace,),
          Row(
            children: [
              Icon(FontAwesomeIcons.circleCheck, color: AppColors.green,size: 20,),
              SizedBox(width: Sizes.md,),
              Expanded(
                child: Text(AppText.sessionScheduleDates,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
          SizedBox(height: Sizes.defaultSpace,),
          Row(
            children: [
              Icon(FontAwesomeIcons.circleCheck, color: AppColors.green,size: 20,),
              SizedBox(width: Sizes.md,),
              Expanded(
                child: Text(AppText.sameDaySession,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
          SizedBox(height: Sizes.defaultSpace,),
          Row(
            children: [
              Icon(FontAwesomeIcons.circleCheck, color: AppColors.green,size: 20,),
              SizedBox(width: Sizes.md,),
              Expanded(
                child: Text(AppText.maximum50,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
          SizedBox(height: Sizes.defaultSpace,),
          Row(
            children: [
              Icon(FontAwesomeIcons.circleCheck, color: AppColors.green,size: 20,),
              SizedBox(width: Sizes.md,),
              Expanded(
                child: Text(AppText.priceCanBe,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}


Widget tipsForSuccess(BuildContext context){
  final dark = context.watch<ThemeProvider>().isDarkMode;
  return Container(
    margin: EdgeInsets.all(Sizes.sm),
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
      padding: const EdgeInsets.all(Sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.tipsForSuccess,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Divider(color: dark? AppColors.white.withOpacity(0.6) : AppColors.black.withOpacity(0.6),),
          SizedBox(height: Sizes.defaultSpace,),
          Row(
            children: [
              Icon(FontAwesomeIcons.handPointRight, color: AppColors.green,size: 20,),
              SizedBox(width: Sizes.md,),
              Expanded(
                child: Text(AppText.chooseClearTitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
          SizedBox(height: Sizes.defaultSpace,),
          Row(
            children: [
              Icon(FontAwesomeIcons.handPointRight, color: AppColors.green,size: 20,),
              SizedBox(width: Sizes.md,),
              Expanded(
                child: Text(AppText.provideDetailTopic,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),

          SizedBox(height: Sizes.defaultSpace,),
          Row(
            children: [
              Icon(FontAwesomeIcons.handPointRight, color: AppColors.green,size: 20,),
              SizedBox(width: Sizes.md,),
              Expanded(
                child: Text(AppText.setDurationLimit,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),

          SizedBox(height: Sizes.defaultSpace,),
          Row(
            children: [
              Icon(FontAwesomeIcons.handPointRight, color: AppColors.green,size: 20,),
              SizedBox(width: Sizes.md,),
              Expanded(
                child: Text(AppText.ensureScheduleAccurate,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),

          SizedBox(height: Sizes.defaultSpace,),
          Row(
            children: [
              Icon(FontAwesomeIcons.handPointRight, color: AppColors.green,size: 20,),
              SizedBox(width: Sizes.md,),
              Expanded(
                child: Text(AppText.prepareMaterialAdvance,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget importantNotes(BuildContext context){
  final dark = context.watch<ThemeProvider>().isDarkMode;
  return Container(
    margin: EdgeInsets.all(Sizes.sm),
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
        padding: const EdgeInsets.all(Sizes.md),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               AppText.importantNotes,
               style: Theme.of(context).textTheme.headlineMedium,
             ),
             Divider(color: dark? AppColors.white.withOpacity(0.6) : AppColors.black.withOpacity(0.6),),
             SizedBox(height: Sizes.defaultSpace,),
             Row(
               children: [
                 Icon(FontAwesomeIcons.triangleExclamation, color: AppColors.yellow,size: 20,),
                 SizedBox(width: Sizes.md,),
                 Expanded(
                   child: Text(AppText.classesCanceledHours,
                     style: Theme.of(context).textTheme.bodyLarge,
                   ),
                 )
               ],
             ),

             SizedBox(height: Sizes.defaultSpace,),
             Row(
               children: [
                 Icon(FontAwesomeIcons.triangleExclamation, color: AppColors.yellow,size: 20,),
                 SizedBox(width: Sizes.md,),
                 Expanded(
                   child: Text(AppText.studentNotified,
                     style: Theme.of(context).textTheme.bodyLarge,
                   ),
                 )
               ],
             ),

             SizedBox(height: Sizes.defaultSpace,),
             Row(
               children: [
                 Icon(FontAwesomeIcons.triangleExclamation, color: AppColors.yellow,size: 20,),
                 SizedBox(width: Sizes.md,),
                 Expanded(
                   child: Text(AppText.paymentProcessCompletion,
                     style: Theme.of(context).textTheme.bodyLarge,
                   ),
                 )
               ],
             ),

             SizedBox(height: Sizes.defaultSpace,),
             Row(
               children: [
                 Icon(FontAwesomeIcons.triangleExclamation, color: AppColors.yellow,size: 20,),
                 SizedBox(width: Sizes.md,),
                 Expanded(
                   child: Text(AppText.scheduleUpdateRegularly,
                     style: Theme.of(context).textTheme.bodyLarge,
                   ),
                 )
               ],
             ),





           ],
         ),
    ),
  );
}