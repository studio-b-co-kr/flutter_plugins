import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:remedi_architecture/remedi.dart';

class SettingsAppModel extends AppModel {
  SettingsAppModel({bool? withInit}) : super(withInit: withInit);

  ThemeMode themeMode = ThemeMode.system;

  toggleThemeMode() {
    bool isDarkMode = themeMode == ThemeMode.system
        ? SchedulerBinding.instance!.window.platformBrightness ==
            Brightness.dark
        : themeMode == ThemeMode.dark;

    if (isDarkMode) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }

    notifyListeners();
  }

  final ThemeData themeDark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.grey.shade900,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.grey.shade50),
      displayMedium: TextStyle(color: Colors.grey.shade50),
      displaySmall: TextStyle(color: Colors.grey.shade50),
      headlineLarge: TextStyle(color: Colors.grey.shade50),
      headlineMedium: TextStyle(color: Colors.grey.shade50),
      headlineSmall: TextStyle(color: Colors.grey.shade50),
      titleLarge: TextStyle(color: Colors.grey.shade50),
      titleMedium: TextStyle(color: Colors.grey.shade50),
      titleSmall: TextStyle(color: Colors.grey.shade50),
    ),
    appBarTheme: AppBarTheme(
      foregroundColor: Colors.grey.shade50,
    ),
  );

  final ThemeData themeLight = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.grey.shade50,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.grey.shade900),
      displayMedium: TextStyle(color: Colors.grey.shade900),
      displaySmall: TextStyle(color: Colors.grey.shade900),
      headlineLarge: TextStyle(color: Colors.grey.shade900),
      headlineMedium: TextStyle(color: Colors.grey.shade900),
      headlineSmall: TextStyle(color: Colors.grey.shade900),
      titleLarge: TextStyle(color: Colors.grey.shade900),
      titleMedium: TextStyle(color: Colors.grey.shade900),
      titleSmall: TextStyle(color: Colors.grey.shade900),
    ),
    appBarTheme: AppBarTheme(
      foregroundColor: Colors.grey.shade900,
    ),
  );

  @override
  initialise() {}
}
