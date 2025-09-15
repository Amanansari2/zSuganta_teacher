import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/theme/provider/theme_provider.dart';

class MyChoiceChip extends StatelessWidget {
  const MyChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;

    return ChoiceChip(
      label: Text(
        text,
        style: TextStyle(
          color: selected ? AppColors.white : (dark ? AppColors.white : AppColors.black),
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      onSelected: onSelected,
      selectedColor: dark ? AppColors.blue : AppColors.orange,
      backgroundColor: dark ? AppColors.black : Colors.grey.shade200,
      checkmarkColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selected
              ? (dark ? AppColors.blue : AppColors.orange)
              : Colors.grey.shade400,
        ),
      ),
    );
  }
}
