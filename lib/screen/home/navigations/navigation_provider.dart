import 'package:flutter/widgets.dart';
import 'package:z_tutor_suganta/screen/accounts/account_screen.dart';
import 'package:z_tutor_suganta/screen/home/classes_screen.dart';
import 'package:z_tutor_suganta/screen/support/support_screen.dart';

class NavigationProvider extends ChangeNotifier{

  final List<Widget> _screens =[
    ClassesScreen(),
    SupportScreen(),
    AccountScreen(),
  ];



  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;


  List<Widget> get screens => _screens;
  Widget get currentScreen => _screens[_selectedIndex];

  void updateIndex(int index){
    if(index >= 0 && index < _screens.length) {
      _selectedIndex = index;
      notifyListeners();
    }
  }




}