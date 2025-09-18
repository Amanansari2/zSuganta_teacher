import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/screen/onboarding/provider/onboarding_provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/device/device_utils.dart';

import '../../../utils/theme/provider/theme_provider.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OnBoardingProvider>();

    // final dark = HelperFunction.isDarkMode(context);
    final dark = context.watch<ThemeProvider>().isDarkMode;

    return Positioned(
        right: Sizes.defaultSpace,
        bottom: DeviceUtils.bottomNavigationBarHeight,
        child: ElevatedButton(

            onPressed: (){
              provider.nextPage(context);
            },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor:  dark ? AppColors.orange : AppColors.blue,
            minimumSize: Size(50, 50)
          ),
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.white,
              size: 35,
            ),


        ));
  }
}
