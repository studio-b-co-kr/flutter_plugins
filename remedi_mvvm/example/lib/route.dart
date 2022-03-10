import 'package:example/features/home/home_page.dart';
import 'package:example/features/home/home_view_model.dart';
import 'package:example/features/settings/settings_page.dart';
import 'package:example/features/splash/splash_page.dart';
import 'package:example/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class RouteGenerator extends IRouteGenerator {
  RouteGenerator({Future Function(String screenName)? screenLogger})
      : super(screenLogger: screenLogger);

  @override
  Route<dynamic>? generateRoute(RouteSettings settings) {
    Route<dynamic>? ret;
    switch (settings.name) {
      case SettingsPage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => const SettingsPage(),
        );
        break;

      case SplashPage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => SplashPage(
            vm: SplashViewModel(),
          ),
        );
        break;

      case HomePage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => HomePage(
            vm: HomeViewModel(),
          ),
        );
        break;
    }
    if (screenLogger != null && ret != null) {
      screenLogger!(settings.name!);
    }
    return ret;
  }
}
