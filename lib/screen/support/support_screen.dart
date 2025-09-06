import 'package:flutter/material.dart';

import '../../utils/theme/theme_switcher_button.dart';
import '../../widgets/custom_app_bar.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text("Support Screen ", style: TextStyle(fontSize: 40),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppThemeSwitcherButton(),

            Text("Support Screen ", style: TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
  }
}
