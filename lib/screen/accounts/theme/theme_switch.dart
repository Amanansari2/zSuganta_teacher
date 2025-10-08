import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/theme/theme_switcher_button.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';
import 'package:z_tutor_suganta/widgets/custom_app_bar.dart';

class ThemeSwitchScreen extends StatelessWidget {
  const ThemeSwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PrimaryHeaderContainer(
              child: Column(
                children: [
                  MyAppBar(
                    showBackArrow: true,
                    title: Text(
                        AppText.switchTheme,
                    style: Theme.of(context).textTheme.headlineMedium!.apply(color: AppColors.white),
                    ),
                  ),

                  SizedBox(height: Sizes.defaultSpace,)
                ],
              )),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ThemeToggleSwitch(),
          )
        ],
      ),
    );
  }
}
