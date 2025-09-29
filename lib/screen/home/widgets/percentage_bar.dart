import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/classes/classes_provider.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import '../../../utils/constants/app_colors.dart';



class ProfileCompletionBar extends StatelessWidget {
  const ProfileCompletionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return Consumer<ClassesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const LinearProgressIndicator(minHeight: 12);
        }

        final percentage = (provider.profileCompletion?.percentage ?? 0).toDouble();
        final progressValue = percentage / 100;


        final incompleteFields = provider.profileCompletion?.getIncompleteFields() ?? [];

        return Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${AppText.profileCompletion} ${percentage.toInt()}%",
                style:  TextStyle(fontWeight: FontWeight.bold, color: dark? AppColors.white :AppColors.black),
              ),
              const SizedBox(height: Sizes.xs),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: progressValue),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) => LinearProgressIndicator(
                    value: value,
                    minHeight: 12,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
                  ),
                ),
              ),
              const SizedBox(height: Sizes.sm),
              if(incompleteFields.isNotEmpty)
              Text(
                AppText.incompleteFields,
                style:  TextStyle(fontWeight: FontWeight.bold, color:dark? AppColors.white : AppColors.black),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: incompleteFields.map((field) {
                  return Chip(
                    backgroundColor: AppColors.white,
                    label: Text(
                      field.label,
                      style:  TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    avatar:  Icon(Icons.close, size: 16, color: AppColors.red),
                    padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
                  );
                }).toList(),
              ),
              if (incompleteFields.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: Sizes.xs),
                  child: Text(
                    AppText.allFieldsCompleted,
                    style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

            ],
          ),
        );
      },
    );
  }
}
