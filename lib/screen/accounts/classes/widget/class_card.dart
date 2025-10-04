import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/helpers/helper_function.dart';

import '../../../../models/accounts/tickets/ticket_details_model.dart';
import '../../../../models/classes/class_list_model.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/user_sessions.dart';
import '../../../../utils/theme/provider/theme_provider.dart';
import '../../../../widgets/custom_button.dart';

class ClassCard extends StatelessWidget {
  final ClassList classData;
  final VoidCallback onPressed;
  const ClassCard({
  super.key,
  required this.classData,
  required this.onPressed
  });

  String formatDate(DateTime? dt) {
    if (dt == null) return '—';
    return DateFormat('yyyy-MM-dd HH:mm').format(dt.toLocal());
  }


  String capitalizeFirstWord(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    final userRole =context.watch<UserSessionProvider>().role.toLowerCase();


    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: dark ? AppColors.black : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: dark
                ? Colors.white
                : Colors.grey,
            blurRadius: 2,

          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Text(
            classData.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color:  dark? AppColors.white : AppColors.black,
            ),
          ),

          SizedBox(height: Sizes.xs,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(userRole != 'teacher')
              Text(
                "Teacher :  ${classData.teacher.name}",
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 1,
              ),


              Text(
                capitalizeFirstWord(classData.subject.name),
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 1,
              ),
            ],
          ),

          Divider( color:  dark? AppColors.white.withOpacity(0.5) : AppColors.black.withOpacity(0.5),),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0, ),
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.dateTime,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: dark? AppColors.white.withOpacity(0.5) : AppColors.black.withOpacity(0.5),
                    ),
                  ),

                  Text(
                    "${HelperFunction.formatDate(classData.date )} ${classData.time}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: Sizes.defaultSpace,),

                  Text(
                    AppText.price,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: dark? AppColors.white.withOpacity(0.5) : AppColors.black.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    classData.price,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                ],
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.duration,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color:  dark? AppColors.white.withOpacity(0.5) : AppColors.black.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    classData.duration.toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  const SizedBox(height: Sizes.defaultSpace,),

                  Text(
                    AppText.status,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color:  dark? AppColors.white.withOpacity(0.5) : AppColors.black.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    capitalizeFirstWord(classData.status),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  
                ],
              )

            ],
          ),
          ),

          const SizedBox(height: Sizes.defaultSpace,),
          Center(
            child: CustomButton(
              text: AppText.viewClassDetails,
              onPressed: onPressed,
              color: dark ? AppColors.blue : AppColors.orange,
              textColor: AppColors.white,
              radius: 15,
              fontSize: Sizes.md,
              width: 300,
            ),
          ),

        ],
      ),
    );

  }
}
