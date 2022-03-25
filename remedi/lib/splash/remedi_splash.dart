import 'package:flutter/material.dart';
import 'package:remedi/splash/feature/intro/intro_wrapper.dart';
import 'package:remedi/splash/feature/login/login_wrapper.dart';
import 'package:remedi/splash/feature/onboarding/onboarding_wrapper.dart';
import 'package:remedi/splash/feature/permission/permission_all_wrapper.dart';
import 'package:remedi/splash/remedi_splash.dart';

import 'feature/force_update/force_update_wrapper.dart';

export 'package:remedi/splash/feature/splash/splash_page.dart';
export 'package:remedi/splash/model/splash_error.dart';
export 'package:remedi/splash/repository/i_splash_repository.dart';

class RemediSplash {
  static const routeName = '/splash';
  static const appOpen = 'app_open';
  static const afterIntro = 'after_intro';
  static const afterPermission = 'after_permission';
  static const afterLogin = 'after_login';
  static const afterOnboarding = 'after_onboarding';

  static Route<dynamic>? generateRoute({
    required RouteSettings settings,
    required Widget background,
    required ISplashRepository repository,
    Widget? forceUpdatePage,
    Widget? introPage,
    Widget? permissionAllPage,
    Widget? loginPage,
    Widget? onboardingPage,
  }) {
    Route? ret;

    switch (settings.name) {
      case RemediSplash.routeName:
        ret = MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return SplashPage(
                from: (settings.arguments ?? RemediSplash.appOpen) as String,
                background: background,
                repository: repository,
              );
            });
        break;
      case ForceUpdateWrapper.routeName:
        ret = MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return ForceUpdateWrapper(
                forceUpdatePage: forceUpdatePage!,
              );
            });
        break;
      case IntroWrapper.routeName:
        ret = MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return IntroWrapper(
                introPage: introPage!,
              );
            });
        break;
      case LoginWrapper.routeName:
        ret = MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return LoginWrapper(
                loginPage: loginPage!,
              );
            });
        break;
      case OnboardingWrapper.routeName:
        ret = MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return OnboardingWrapper(
                onboardingPage: onboardingPage!,
              );
            });
        break;
      case PermissionAllWrapper.routeName:
        ret = MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return PermissionAllWrapper(
                permissionAllPage: permissionAllPage!,
              );
            });
        break;
    }
    return ret;
  }
}
