import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';

import '../../utils/theme/provider/theme_provider.dart';

class CustomDialog {
  static void show(
      BuildContext context, {
        required String title,
        required String message,
        IconData? icon,
        Color? iconColor,
        String? positiveButtonText,
        String? negativeButtonText,
        VoidCallback? onPositivePressed,
        VoidCallback? onNegativePressed,
        bool dismissible = true,
      }) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDark = themeProvider.isDarkMode;

    final buttonsCount = [
      if (positiveButtonText != null) 1,
      if (negativeButtonText != null) 1
    ].length;

    MainAxisAlignment buttonAlignment =
    buttonsCount == 1 ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween;

    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (ctx) => Dialog(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                CircleAvatar(
                  backgroundColor: iconColor ?? (isDark ? AppColors.blue : AppColors.orange),
                  radius: 30,
                  child: Icon(icon, color: AppColors.white, size: 30),
                ),
              if (icon != null) SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.white : AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color:  isDark ? AppColors.white : AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              if (buttonsCount > 0) SizedBox(height: 20),
              if (buttonsCount > 0)
                Row(
                  mainAxisAlignment: buttonAlignment,
                  children: [
                    if (negativeButtonText != null)
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          if (onNegativePressed != null) onNegativePressed();
                        },
                        child: Text(
                          negativeButtonText,
                          style: TextStyle(color:  AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    if (positiveButtonText != null)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          if (onPositivePressed != null) onPositivePressed();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? AppColors.blue : AppColors.orange,
                        ),
                        child: Text(positiveButtonText,
                          style: TextStyle(color:  AppColors.white,
                          fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
