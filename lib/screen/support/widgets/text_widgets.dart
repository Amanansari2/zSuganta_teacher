import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';

Widget doubleTextItem({
  required BuildContext context,
  required Color color,
  required String colorText,
  required String label,
  required String description
}) {
  final dark = context.watch<ThemeProvider>().isDarkMode;

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: dark ? AppColors.blue : AppColors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: dark ? Colors.white38 : Colors.grey,
          blurRadius: 3
        )
      ]
    ),

    child:  Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
              colorText,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight:  FontWeight.bold,
              fontSize: 16
            ),
          ),
        ),

        const SizedBox(width: Sizes.defaultSpace,),

        Column(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: Sizes.xs,),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        )
      ],
    ),
  );
}



Widget singleTextItem({
  required BuildContext context,
  required Color color,
  required String colorText,
  required String label,
}) {
  final dark = context.watch<ThemeProvider>().isDarkMode;

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        color: dark ? AppColors.blue : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: dark ? Colors.white38 : Colors.grey,
              blurRadius: 3
          )
        ]
    ),

    child:  Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            colorText,
            style: const TextStyle(
                color: AppColors.white,
                fontWeight:  FontWeight.bold,
                fontSize: 16
            ),
          ),
        ),

        const SizedBox(width: Sizes.defaultSpace,),

        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        )
      ],
    ),
  );
}


Widget iconTextItem({
  required BuildContext context,
  required String label,
}) {
  final dark = context.watch<ThemeProvider>().isDarkMode;
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        color: dark ? AppColors.blue : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: dark ? Colors.white38 : Colors.grey,
              blurRadius: 3
          )
        ]
    ),

    child:  Row(
      children: [
        Icon(FontAwesomeIcons.check, color: AppColors.green,),

        const SizedBox(width: Sizes.defaultSpace,),

        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        )
      ],
    ),
  );
}
