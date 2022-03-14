import 'dart:async';
import 'dart:developer' as dev;

import 'package:example/providers/auth_app_model.dart';
import 'package:example/providers/color_app_model.dart';
import 'package:example/providers/settings_app_model.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class HomeViewModel extends IViewModel {
  StateData<CountState, int> stateData = StateData(state: CountState.waiting);
  int count = 0;

  StreamSubscription? subscription;

  @override
  initialise() {
    subscription = Stream.periodic(const Duration(seconds: 1), (count) {
      return count;
    }).listen((event) {
      count++;
      updateUi();
    });
  }

  late AuthAppModel _authAppModel;
  late ColorAppModel _colorAppModel;
  late SettingsAppModel _settingsAppModel;

  AuthAppModel get authAppModel => _authAppModel;

  ColorAppModel get colorAppModel => _colorAppModel;

  SettingsAppModel get settingsAppModel => _settingsAppModel;

  void listenAuthChanged() {
    loginState = _authAppModel.loginState;
    updateUi();
    dev.log('listen',
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
    subscription?.cancel();
    subscription = null;
  }

  @override
  void dispose() {
    removeAuthListener();
    super.dispose();
  }
}

enum CountState {
  waiting,
  increased,
}
