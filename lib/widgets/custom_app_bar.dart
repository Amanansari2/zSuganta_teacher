import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/device/device_utils.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';

import '../utils/constants/sizes.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool centerTitle;
  
  const MyAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.centerTitle = false
  });

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.xs),
    child: AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
      ? IconButton(
          onPressed: () => context.pop(),
          icon: Icon(FontAwesomeIcons.arrowLeft,
            // color: dark ? AppColors.white : AppColors.black,))
            color: AppColors.white,))
          : leadingIcon != null
          ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
          : null,
      title: title,
      actions: actions,
      centerTitle: centerTitle,
    ),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.appBarHeight);
}
