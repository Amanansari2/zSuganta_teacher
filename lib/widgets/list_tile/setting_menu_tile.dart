import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';

class SettingMenuTile extends StatelessWidget {
  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  const SettingMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: dark ? AppColors.blue : AppColors.orange,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
