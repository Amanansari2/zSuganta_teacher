import 'package:flutter/material.dart';
import 'package:z_tutor_suganta/widgets/custom_app_bar.dart';

import '../../utils/theme/theme_switcher_button.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text("Home Screen ", style: TextStyle(fontSize: 40),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppThemeSwitcherButton(),

            Text("Home Screen ", style: TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
  }
}
