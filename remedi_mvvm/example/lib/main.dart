import 'dart:developer' as dev;

import 'package:example/features/auth/auth_app_model.dart';
import 'package:example/features/deeplink/deeplink_app_model.dart';
import 'package:example/features/home/home_page.dart';
import 'package:example/features/home/home_view_model.dart';
import 'package:example/features/settings/settings_page.dart';
import 'package:example/features/settings/settings_view_model.dart';
import 'package:example/features/splash/splash_page.dart';
import 'package:example/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

void main() {
  app.run(
    readyToRun: () async {
      /// TODO do something before run app
      /// ex. register firebase and etc.
    },
    handleError: (error, stackTrace) async {
      /// TODO do something if there is an error not caught
      /// ex. exit app, report bug and etc
      dev.log('error = ${error.toString()}', name: '');
      dev.log('stackTrace = ${stackTrace.toString()}', name: '');
      // exit(1);
    },
  );
}

RemediApp app = RemediApp(
  globalProviderBuilder: () => [
    ChangeNotifierProvider<SettingsViewModel>(
        create: (context) => SettingsViewModel()),
    ChangeNotifierProvider<DeeplinkAppModel>(
        create: (context) => DeeplinkAppModel()),
    ChangeNotifierProvider<AuthAppModel>(create: (context) => AuthAppModel()),
  ],
  appBuilder: () => MaterialApp(
    navigatorKey: RemediApp.navigatorKey,
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData(
      colorScheme: const ColorScheme.dark(),
    ),
    theme: ThemeData(
      colorScheme: const ColorScheme.light(),
    ),
    initialRoute: SplashPage.routeName,
    onGenerateRoute: (settings) =>
        RouteGenerator(screenLogger: (routeName) async {
      dev.log(routeName, name: 'ScreenLogger');
    }).generateRoute(settings),
  ),
);

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
