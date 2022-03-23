import 'dart:developer' as dev;

import 'package:example/app_models/auth_app_model.dart';
import 'package:example/app_models/settings_app_model.dart';
import 'package:example/features/contents/contents_page.dart';
import 'package:example/features/settings/settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class HomeViewModel extends ViewModel {
  static HomeViewModel _instance = HomeViewModel._();

  HomeViewModel._();

  factory HomeViewModel.singleton() {
    if (_instance.isDisposed) {
      _instance = HomeViewModel._();
    }

    return _instance;
  }

  final StateData<CountState, int> stateData =
      StateData(state: CountState.waiting, data: 0);

  increase() {
    if (stateData.data != null) {
      stateData.data = stateData.data! + 1;
      dev.log('increase', name: toString());
      updateUi();
      // updateAction('increase');
    }
  }

  int get count => stateData.data!;

  late AuthAppModel _authAppModel;

  late SettingsAppModel _settingsAppModel;

  AuthAppModel get authAppModel => _authAppModel;

  SettingsAppModel get settingsAppModel => _settingsAppModel;

  void toggleThemeMode() {
    settingsAppModel.toggleThemeMode();
  }

  void listenAuthChanged() {
    loginState.data = _authAppModel.loginState.data;
    loginState.state = _authAppModel.loginState.state;
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
      dev.log('removeAuthChanged', name: toString());
    }
  }

  final StateData<LoginState, bool> loginState =
      StateData(state: LoginState.loggedOut, data: false);

  bool linkedAppModels = false;

  @override
  linkAppModels(BuildContext context) {
    if (!linkedAppModels) {
      linkedAppModels = true;
      _authAppModel = Provider.of<AuthAppModel>(context, listen: false);
      _authAppModel.addListener(listenAuthChanged);
      _settingsAppModel = Provider.of<SettingsAppModel>(context);
    }
  }

  void goSettings() {
    RemediRouter.pushNamed(SettingsPage.routeName);
  }

  void goContents() {
    RemediRouter.pushNamed(ContentsPage.routeName);
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
