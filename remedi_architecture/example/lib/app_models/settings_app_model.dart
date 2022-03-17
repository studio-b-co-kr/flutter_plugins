import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class SettingsAppModel extends IAppModel {
  SettingsAppModel({bool? withInit}) : super(withInit: withInit);

  ThemeMode themeMode = ThemeMode.dark;

  changeTheme(ThemeMode themeMode) {
    this.themeMode = themeMode;
    notifyListeners();
  }

  final ThemeData themeDark = ThemeData();

  final ThemeData themeLight = ThemeData();

  @override
  initialise() {}
}
