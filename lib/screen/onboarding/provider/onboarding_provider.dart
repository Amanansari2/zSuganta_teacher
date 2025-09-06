import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';

class OnBoardingProvider extends ChangeNotifier{
  Timer? _timer;

  final pageController = PageController();
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;



  void startAutoPageMove(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer){
      if(_currentPageIndex >= 2){
        _timer?.cancel();
      } else{
        nextPage(context);
      }
    });
  }



  void updatePageIndicator(int index){
    _currentPageIndex = index;
    notifyListeners();
  }

  void dotNavigationClick(int index){
    _currentPageIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  void nextPage(BuildContext context) async {
    final totalPages = 3;

    if(_currentPageIndex >= totalPages -1){
      _timer?.cancel();
      await LocalStorageService.setOnboardingSeen();
      context.goNamed('signIn');
    } else {
      int page = _currentPageIndex +1;
      pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut
      );
    }
  }

  void skipPage (BuildContext context) async {
    final totalPages = 3;
    _timer?.cancel();
    _currentPageIndex = totalPages - 1;

    pageController.jumpToPage(totalPages - 1);
    notifyListeners();

    await LocalStorageService.setOnboardingSeen();
    context.goNamed('signIn');
  }



  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

}