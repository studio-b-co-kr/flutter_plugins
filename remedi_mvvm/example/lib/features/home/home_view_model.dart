import 'package:example/features/auth/auth_app_model.dart';
import 'package:example/features/deeplink/deeplink_app_model.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class HomeViewModel extends ViewModel {
  @override
  init() {}

  late AuthAppModel _authAppModel;
  late DeeplinkAppModel _deeplinkAppModel;

  AuthAppModel get authAppModel => _authAppModel;

  DeeplinkAppModel get deeplinkAppModel => _deeplinkAppModel;

  @override
  linkAppProviders(BuildContext context) {
    _authAppModel = Provider.of<AuthAppModel>(context);
    _deeplinkAppModel = Provider.of<DeeplinkAppModel>(context);
  }
}
