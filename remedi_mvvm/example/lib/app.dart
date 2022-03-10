import 'dart:developer' as dev;

import 'package:example/features/auth/auth_app_model.dart';
import 'package:example/features/deeplink/deeplink_app_model.dart';
import 'package:example/features/settings/settings_view_model.dart';
import 'package:example/features/splash/splash_page.dart';
import 'package:example/route.dart';
import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

RemediApp app = RemediApp(
  globalProviders: [
    ChangeNotifierProvider<SettingsViewModel>(
        create: (context) => SettingsViewModel()),
    ChangeNotifierProvider<DeeplinkAppModel>(
        create: (context) => DeeplinkAppModel()),
    ChangeNotifierProvider<AuthAppModel>(create: (context) => AuthAppModel()),
  ],
  initGlobalProvider: (context) {
    dev.log('start app', name: 'ExampleApp');
    Provider.of<DeeplinkAppModel>(context, listen: false).init();
    Provider.of<SettingsViewModel>(context, listen: false).init();
    Provider.of<AuthAppModel>(context, listen: false).init();
  },
  app: MaterialApp(
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
