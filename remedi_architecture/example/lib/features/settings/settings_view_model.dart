import 'package:example/app_models/settings_app_model.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class SettingsViewModel extends IViewModel {
  static SettingsViewModel _instance = SettingsViewModel._();

  SettingsViewModel._();

  factory SettingsViewModel.singleton() {
    if (_instance.isDisposed) {
      _instance = SettingsViewModel._();
    }

    return _instance;
  }

  @override
  initialise() {}

  void toggleThemeMode() {
    _settingsAppModel.toggleThemeMode();
  }

  late SettingsAppModel _settingsAppModel;

  @override
  linkAppModels(BuildContext context) {
    _settingsAppModel = Provider.of<SettingsAppModel>(context);
  }
}
