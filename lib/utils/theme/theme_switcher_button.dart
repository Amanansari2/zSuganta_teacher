import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/helpers/helper_function.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class AppThemeSwitcherButton extends StatelessWidget {
  const AppThemeSwitcherButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    ThemeMode currentMode = themeProvider.themeMode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(context, "System", ThemeMode.system, currentMode),
        const SizedBox(width: 8),
        _buildButton(context, "Light", ThemeMode.light, currentMode),
        const SizedBox(width: 8),
        _buildButton(context, "Dark", ThemeMode.dark, currentMode),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String label, ThemeMode mode,
      ThemeMode currentMode) {
    final themeProvider = context.read<ThemeProvider>();
    bool isSelected = currentMode == mode;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      onPressed: () {
        themeProvider.setTheme(mode);
      },
      child: Text(label),
    );
  }
}


class ThemeToggleButton extends StatelessWidget {


  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final bool isDark = themeProvider.themeMode == ThemeMode.dark;
    return IconButton(
        onPressed: (){
          final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
          themeProvider.setTheme(newMode);
        },
        icon:Icon( isDark ? FontAwesomeIcons.solidMoon: FontAwesomeIcons.solidSun, color: AppColors.white,)
    );
  }
}



class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           AppText.chooseTheme,
          style: Theme.of(context).textTheme.headlineLarge
        ),
        const SizedBox(height: 8),
         Text(
         AppText.selectTheme,
          style: Theme.of(context).textTheme.titleMedium
        ),
        const SizedBox(height: 24),
        _buildSwitch(
          context,
          label: "Light Mode",
          isOn: themeProvider.themeMode == ThemeMode.light,
          onChanged: (bool value) => themeProvider.setTheme(ThemeMode.light),
        ),
        const SizedBox(height: 16),
        _buildSwitch(
          context,
          label: "Dark Mode",
          isOn: themeProvider.themeMode == ThemeMode.dark,
          onChanged: (bool value) => themeProvider.setTheme(ThemeMode.dark),
        ),
        const SizedBox(height: 16),
        _buildSwitch(
          context,
          label: "System Default",
          isOn: themeProvider.themeMode == ThemeMode.system,
          onChanged: (bool value) => themeProvider.setTheme(ThemeMode.system),
        ),
      ],
    );
  }

  Widget _buildSwitch(
      BuildContext context, {
        required String label,
        required bool isOn,
        required ValueChanged<bool> onChanged,
      }) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return Container(
      height: 70,
      width: HelperFunction.screenWidth(context),
      decoration: BoxDecoration(
        color: dark ? AppColors.black : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: dark ? AppColors.white : AppColors.black.withOpacity(0.7),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.headlineSmall

            ),
            Switch(
              value: isOn,
              onChanged: onChanged,
              activeColor: dark ? AppColors.blue : AppColors.orange,
              inactiveTrackColor: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}











