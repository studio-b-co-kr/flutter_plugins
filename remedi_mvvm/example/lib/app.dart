import 'dart:developer' as dev;

import 'package:example/features/splash/splash_page.dart';
import 'package:example/providers/auth_app_model.dart';
import 'package:example/providers/deeplink_app_model.dart';
import 'package:example/providers/settings_app_model.dart';
import 'package:example/route.dart';
import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

RemediApp app = RemediApp(
  globalProviders: [
    ChangeNotifierProvider<DeeplinkAppModel>(
        create: (context) => DeeplinkAppModel(withInit: true)),
    ChangeNotifierProvider<SettingsAppModel>(
        create: (context) => SettingsAppModel(withInit: true)),
    ChangeNotifierProvider<AuthAppModel>(
        create: (context) => AuthAppModel(withInit: true)),
  ],
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
