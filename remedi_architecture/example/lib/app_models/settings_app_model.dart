import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class SettingsAppModel extends AppModel {
  SettingsAppModel({bool? withInit}) : super(withInit: withInit);

  ThemeMode themeMode = ThemeMode.dark;

  toggleThemeMode() {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  final ThemeData themeDark = ThemeData(
    colorScheme: const ColorScheme.dark(),
  );

  final ThemeData themeLight = ThemeData(
    colorScheme: const ColorScheme.light(),
  );

  @override
  initialise() {}
}
