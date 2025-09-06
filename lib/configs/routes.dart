import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/authentication/forgot_password_provider.dart';
import 'package:z_tutor_suganta/providers/authentication/signin_provider.dart';
import 'package:z_tutor_suganta/providers/authentication/signup_provider.dart';
import 'package:z_tutor_suganta/screen/accounts/profile/update_profile.dart';
import 'package:z_tutor_suganta/screen/authentication/resend_email.dart';
import 'package:z_tutor_suganta/screen/authentication/signin.dart';
import 'package:z_tutor_suganta/screen/authentication/signup.dart';
import 'package:z_tutor_suganta/screen/home/classes_screen.dart';
import 'package:z_tutor_suganta/screen/home/navigations/navigation_menu.dart';
import 'package:z_tutor_suganta/screen/onboarding/onboarding.dart';
import 'package:z_tutor_suganta/screen/onboarding/provider/onboarding_provider.dart';
import 'package:z_tutor_suganta/screen/support/support_screen.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';

import '../screen/accounts/account_screen.dart';
import '../screen/authentication/forgot_password.dart';

class AppRouter{

  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router =  GoRouter(
    navigatorKey: rootNavigatorKey,
        initialLocation: _getInitialRoutes(),
        routes: [
          GoRoute(
              name: 'onboarding',
              path: '/onboarding',
              builder: (context, state) =>
                  ChangeNotifierProvider(
                    create: (_) => OnBoardingProvider(),
                    child: OnboardingScreen(),
                  )
          ),

          GoRoute(
            name: 'signUp',
            path: '/signUp',
            builder: (context, state) =>
                ChangeNotifierProvider(
                    create: (_) => SignUpProvider(),
                    child: SignUpScreen()),
          ),

          GoRoute(
            name: 'signIn',
            path: '/signIn',
            builder: (context, state) =>
                ChangeNotifierProvider(
                    create: (_) => SignInProvider(),
                    child: SignInScreen()),
          ),

          GoRoute(
              name: 'forgotPassword',
              path: '/forgotPassword',
              builder: (context, state) =>
                  ChangeNotifierProvider(
                      create: (_) => ForgotPasswordProvider(),
                      child: ForgotPasswordScreen())
          ),

          GoRoute(
              name: 'resendEmail',
              path: '/resendEmail',
              builder: (context, state) =>
                  ChangeNotifierProvider(
                      create: (_) => SignInProvider(),
                      child: ResendEmailScreen())
          ),

          GoRoute(
            name: 'bottomBar',
            path: '/bottomBar',
            builder: (context, state) => NavigationMenu(),
          ),


          GoRoute(
            name: 'classesScreen',
            path: '/classesScreen',
            builder: (context, state) => ClassesScreen(),
          ),

          GoRoute(
            name: 'supportScreen',
            path: '/supportScreen',
            builder: (context, state) => SupportScreen(),
          ),

          GoRoute(
            name: 'accountScreen',
            path: '/accountScreen',
            builder: (context, state) => AccountScreen(),
          ),

          GoRoute(
            name: 'updateProfileScreen',
            path: '/updateProfileScreen',
            builder: (context, state) => UpdateProfileScreen(),
          ),


        ],
        debugLogDiagnostics: true
    );

  static String _getInitialRoutes(){
    final onboardingSeen = LocalStorageService.isOnboardingSeen();
    final token = LocalStorageService.getToken();
    if(!onboardingSeen){
      return '/onboarding';
    } else{
      return token != null && token.isNotEmpty ? '/bottomBar' : '/signIn';
    }
  }
  }
