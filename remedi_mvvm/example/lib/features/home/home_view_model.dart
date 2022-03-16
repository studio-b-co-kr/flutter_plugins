import 'dart:developer' as dev;

import 'package:example/app_models/auth_app_model.dart';
import 'package:example/app_models/color_app_model.dart';
import 'package:example/app_models/settings_app_model.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class HomeViewModel extends IViewModel {
  final StateData<CountState, int> stateData =
      StateData(state: CountState.waiting, data: 0);

  increase() {
    if (stateData.data != null) {
      stateData.data = stateData.data! + 1;
      updateAction('increase');
    }
  }

  int get count => stateData.data!;

  late AuthAppModel _authAppModel;
  late ColorAppModel _colorAppModel;
  late SettingsAppModel _settingsAppModel;

  AuthAppModel get authAppModel => _authAppModel;

  ColorAppModel get colorAppModel => _colorAppModel;

  SettingsAppModel get settingsAppModel => _settingsAppModel;

  void listenAuthChanged() {
    loginState = _authAppModel.loginState;
    updateUi();
    // updateAction('login');
    dev.log('listen : ${_authAppModel.loginState.state}',
        name: '${_authAppModel.toString()}.${_authAppModel.hashCode}');
    dev.log('listen : ${_authAppModel.loginState.data}',
        name: '${_authAppModel.toString()}.${_authAppModel.hashCode}');
  }

  removeAuthListener() {
    try {
      _authAppModel.removeListener(listenAuthChanged);
    } catch (e) {
      dev.log('removeAuthChanged', name: '${toString()}.$hashCode');
    }
  }

  StateData<LoginState, bool> loginState =
      StateData(state: LoginState.loggedOut, data: false);

  @override
  linkAppModels(BuildContext context) {
    removeAuthListener();
    _authAppModel = Provider.of<AuthAppModel>(context, listen: false);
    _authAppModel.addListener(listenAuthChanged);
    _colorAppModel = Provider.of<ColorAppModel>(context);
    _settingsAppModel = Provider.of<SettingsAppModel>(context);
  }

  @override
  void onHotReload() {
    super.onHotReload();
    removeAuthListener();
  }

  @override
  void dispose() {
    removeAuthListener();
    super.dispose();
  }

  @override
  initialise() {}
}

enum CountState {
  waiting,
  increased,
}
