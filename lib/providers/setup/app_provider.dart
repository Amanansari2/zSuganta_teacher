import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/accounts/institute_information_provider.dart';
import 'package:z_tutor_suganta/providers/accounts/social_link_provider.dart';
import 'package:z_tutor_suganta/providers/accounts/teaching_information_provider.dart';
import 'package:z_tutor_suganta/providers/authentication/get_user_profile_provider.dart';
import 'package:z_tutor_suganta/screen/home/navigations/navigation_provider.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';

import '../accounts/sessions_provider.dart';

class AppProvider {
  static List<ChangeNotifierProvider> providers = [

    ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider()),

    ChangeNotifierProvider<GetUserProfileProvider>(
        create: (_) => GetUserProfileProvider()),

    ChangeNotifierProvider<SocialLinkProvider>(
        create: (_) => SocialLinkProvider()),

    ChangeNotifierProvider<TeachingInformationProvider>(
        create: (_) => TeachingInformationProvider()),

    ChangeNotifierProvider<InstituteInformationProvider>(
        create: (_) => InstituteInformationProvider()),

    ChangeNotifierProvider<NavigationProvider>(
        create: (_) => NavigationProvider()),

    ChangeNotifierProvider<SessionsProvider>(
        create: (_) => SessionsProvider()),


  ];
}