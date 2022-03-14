import 'dart:async';

import 'package:example/features/auth/auth_app_model.dart';
import 'package:example/features/deeplink/deeplink_app_model.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class HomeViewModel extends ViewModel {
  StateData<CountState, int> stateData = StateData(state: CountState.waiting);
  int count = 0;

  StreamSubscription? subscription;

  @override
  init() {
    subscription = Stream.periodic(const Duration(seconds: 30), (count) {
      return count;
    }).listen((event) {
      count++;
      updateUi();
    });
  }

  late AuthAppModel _authAppModel;
  late DeeplinkAppModel _deeplinkAppModel;

  AuthAppModel get authAppModel => _authAppModel;

  DeeplinkAppModel get deeplinkAppModel => _deeplinkAppModel;

  @override
  linkAppProviders(BuildContext context) {
    _authAppModel = Provider.of<AuthAppModel>(context);
    _deeplinkAppModel = Provider.of<DeeplinkAppModel>(context);
  }

  @override
  void onHotReload() {
    super.onHotReload();
    subscription?.cancel();
    subscription = null;
  }
}

enum CountState {
  waiting,
  increased,
}
