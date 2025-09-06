import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceUtils{

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
      enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
    );
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static Future<void> setPreferredOrientation(List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double pixelRatio(BuildContext context) => MediaQuery.of(context).devicePixelRatio;
  static double statusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top;
  static double keyboardHeight(BuildContext context) => MediaQuery.of(context).viewInsets.bottom;

  static bool isKeyboardVisible(BuildContext context) => MediaQuery.of(context).viewInsets.bottom > 0;

  static double bottomNavigationBarHeight = kBottomNavigationBarHeight;
  static double appBarHeight = kToolbarHeight;


  static bool isIOS() => Platform.isIOS;
  static bool isAndroid() => Platform.isAndroid;

  static bool isPhysicalDevice() {
    return defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
  }

  static void vibrate([Duration duration = const Duration(milliseconds: 100)]) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }


}