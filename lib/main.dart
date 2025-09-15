import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/setup/app_provider.dart';
import 'package:z_tutor_suganta/configs/routes.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';
import 'package:z_tutor_suganta/utils/theme/app_theme.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();

  runApp(
      MultiProvider(
        providers: [
          ...AppProvider.providers,
        ChangeNotifierProvider(
            create: (_) => UserSessionProvider()..init())
        ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}


