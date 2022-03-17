import 'dart:developer' as dev;

import 'package:example/app_models/auth_app_model.dart';
import 'package:example/app_models/color_app_model.dart';
import 'package:example/app_models/settings_app_model.dart';
import 'package:example/features/splash/splash_page.dart';
import 'package:example/route.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

RemediApp app = RemediApp(
  enableLog: false,
  globalProviders: [
    ChangeNotifierProvider<ColorAppModel>(
        create: (context) => ColorAppModel(withInit: true)),
    ChangeNotifierProvider<SettingsAppModel>(
        create: (context) => SettingsAppModel()),
    ChangeNotifierProvider<AuthAppModel>(create: (context) => AuthAppModel()),
  ],
  appBuilder: (context) => MaterialApp(
    navigatorKey: RemediApp.navigatorKey,
    themeMode: context.watch<SettingsAppModel>().themeMode,
    darkTheme: context.read<SettingsAppModel>().themeDark,
    theme: context.read<SettingsAppModel>().themeLight,
    initialRoute: SplashPage.routeName,
    onGenerateRoute: (settings) =>
        RouteGenerator(screenLogger: (routeName) async {
      dev.log(routeName, name: 'ScreenLogger');
    }).generateRoute(settings),
  ),
);
