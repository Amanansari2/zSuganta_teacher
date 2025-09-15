// lib/widgets/dialog/session_overlay.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';

import '../../configs/routes.dart';
import '../../utils/theme/provider/theme_provider.dart';

class SessionOverlay {
  static OverlayEntry? _entry;
  static bool get isShowing => _entry != null;

  static void showAndRedirect({int delaySeconds = 3}) {
    final navState = AppRouter.rootNavigatorKey.currentState;
    if (navState == null) return;

    final overlay = navState.overlay;
    if (overlay == null) return;

    if (_entry != null) return;

    final dark =   Provider.of<ThemeProvider>(navState.context, listen: false).isDarkMode;

    _entry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          const Positioned.fill(
            child: ModalBarrier(dismissible: false, color: Colors.black45),
          ),
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 220),
              builder: (context, value, child) =>
                  Opacity(opacity: value, child: child),
              child: Material(
                color: dark ? AppColors.blue : AppColors.orange,
                elevation: 10,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "Session expired \nLogout Successfully \nPlease login again",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.white),
                      ),
                      SizedBox(height: 16),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_entry!);

    Future.delayed(Duration(seconds: delaySeconds), () {
      try {
        _entry?.remove();
      } catch (_) {}
      _entry = null;

      // always redirect
      AppRouter.router.goNamed('signIn');
    });
  }

}
