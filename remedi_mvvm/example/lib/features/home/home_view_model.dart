import 'dart:async';
import 'dart:developer' as dev;

import 'package:example/providers/auth_app_model.dart';
import 'package:example/providers/deeplink_app_model.dart';
import 'package:example/providers/settings_app_model.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class HomeViewModel extends ViewModel {
  StateData<CountState, int> stateData = StateData(state: CountState.waiting);
  int count = 0;

  StreamSubscription? subscription;

  @override
  initialise() {
    subscription = Stream.periodic(const Duration(seconds: 30), (count) {
      return count;
    }).listen((event) {
      count++;
      updateUi();
    });
  }

  late AuthAppModel _authAppModel;
  late DeeplinkAppModel _deeplinkAppModel;
  late SettingsAppModel _settingsAppModel;

  AuthAppModel get authAppModel => _authAppModel;

  DeeplinkAppModel get deeplinkAppModel => _deeplinkAppModel;

  SettingsAppModel get settingsAppModel => _settingsAppModel;

  void listenAuthChanged() {
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

  @override
  linkAppProviders(BuildContext context) {
    removeAuthListener();
    _authAppModel = Provider.of<AuthAppModel>(context, listen: false);
    _authAppModel.addListener(listenAuthChanged);
    _deeplinkAppModel = Provider.of<DeeplinkAppModel>(context);
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
