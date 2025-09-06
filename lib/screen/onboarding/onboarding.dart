import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/screen/onboarding/provider/onboarding_provider.dart';
import 'package:z_tutor_suganta/screen/onboarding/widgets/onboard_skip.dart';
import 'package:z_tutor_suganta/screen/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:z_tutor_suganta/screen/onboarding/widgets/onboarding_next_button.dart';
import 'package:z_tutor_suganta/screen/onboarding/widgets/onboarding_page.dart';
import 'package:z_tutor_suganta/utils/constants/image_strings.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/theme/theme_switcher_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<OnBoardingProvider>(context, listen: false);
     provider.startAutoPageMove(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnBoardingProvider>();
    return Scaffold(
      body: Stack(
        children: [
          PageView(
      controller: provider.pageController,
            onPageChanged: provider.updatePageIndicator,
            children: const [
              OnboardingPage(
                image: AppImages.onBoardingImage1,
                title: AppText.onBoardingTitle1,
                subtitle: AppText.onBoardingSubTitle1),


          OnboardingPage(
              image: AppImages.onBoardingImage2,
              title: AppText.onBoardingTitle2,
              subtitle: AppText.onBoardingSubTitle2),

          OnboardingPage(
              image: AppImages.onBoardingImage3,
              title: AppText.onBoardingTitle3,
              subtitle: AppText.onBoardingSubTitle3),
    ]
    ),

          Positioned(
            left: Sizes.defaultSpace,
              top: Sizes.appBarHeight,
              child: AppThemeSwitcherButton()),


          const OnBoardingSkip(),

          const OnboardingDotNavigation(),

          const OnboardingNextButton()

        ],
      ),

    );
  }
}
