import 'package:example/app_models/settings_app_model.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class SettingsViewModel extends IViewModel {
  static SettingsViewModel? _instance;

  SettingsViewModel._();

  static SettingsViewModel get instance {
    if (_instance?.isDisposed ?? true) {
      _instance = null;
      _instance = SettingsViewModel._();
    }
    return _instance!;
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
