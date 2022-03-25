library remedi_splash;

import 'package:flutter/material.dart';
import 'package:remedi_splash/remedi_splash.dart';

export 'package:remedi_splash/feature/splash/splash_page.dart';
export 'package:remedi_splash/model/splash_error.dart';
export 'package:remedi_splash/repository/i_splash_repository.dart';

class RemediSplash {
  static const routeNameAppOpen = "/splash/app_open";
  static const routeNameAfterIntro = "/splash/after_intro";
  static const routeNameAfterPermission = "/splash/after_permission";
  static const routeNameAfterLogin = "/splash/after_login";
  static const routeNameAfterOnboarding = "/splash/after_onboarding";

  static Route<dynamic>? generateRoute({
    required RouteSettings settings,
    required Widget background,
    required ISplashRepository repository,
  }) {
    Route? ret;

    switch (settings.name) {
      case RemediSplash.routeNameAppOpen:
        ret = MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return SplashPage(
                background: background,
                repository: repository,
              );
            });
        break;
    }
    return ret;
  }
}
