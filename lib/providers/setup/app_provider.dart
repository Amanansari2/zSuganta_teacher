import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/authentication/get_user_profile_provider.dart';
import 'package:z_tutor_suganta/screen/home/navigations/navigation_provider.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';

class AppProvider {
  static List<ChangeNotifierProvider> providers = [

    ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider()),

    ChangeNotifierProvider<GetUserProfileProvider>(
        create: (_) => GetUserProfileProvider()),

    ChangeNotifierProvider<NavigationProvider>(
        create: (_) => NavigationProvider()),





  ];
}