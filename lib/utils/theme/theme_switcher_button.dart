import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        icon:Icon( isDark ? FontAwesomeIcons.solidMoon: FontAwesomeIcons.solidSun,)
    );
  }
}
