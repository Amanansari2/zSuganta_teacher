import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:z_tutor_suganta/screen/onboarding/provider/onboarding_provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/device/device_utils.dart';

import '../../../utils/theme/provider/theme_provider.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OnBoardingProvider>();
    // final dark = HelperFunction.isDarkMode(context);
    final dark = context.watch<ThemeProvider>().isDarkMode;

    return Positioned(
        bottom: DeviceUtils.bottomNavigationBarHeight + 25,
        left: Sizes.defaultSpace,
        child: SmoothPageIndicator(
            controller: provider.pageController,
            count: 3,
            onDotClicked: provider.dotNavigationClick,
          effect: ExpandingDotsEffect(
            activeDotColor: dark ? AppColors.orange : AppColors.blue,
            dotHeight: 5
          ),
        ));
  }
}
