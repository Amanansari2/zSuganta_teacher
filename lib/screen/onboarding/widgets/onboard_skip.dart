import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/screen/onboarding/provider/onboarding_provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/device/device_utils.dart';

import '../../../utils/theme/provider/theme_provider.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OnBoardingProvider>();
    // final dark = HelperFunction.isDarkMode(context);
    final dark = context.watch<ThemeProvider>().isDarkMode;

    return Positioned(
      top: DeviceUtils.appBarHeight,
        right: Sizes.spaceBtwSections,
        child: TextButton(
            onPressed: ()  {
               provider.skipPage(context);
            },
            child: Text(
                'Skip',
            style: TextStyle(
              fontSize: Sizes.lg,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              fontWeight: FontWeight.bold,
              color: dark ? AppColors.orange : AppColors.blue
            ),
            ),

        ));
  }
}
