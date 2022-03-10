import 'package:example/features/auth/auth_app_model.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class HomeViewModel extends ViewModel {
  @override
  init() {}

  late AuthAppModel _authAppModel;

  AuthAppModel get authAppModel => _authAppModel;

  @override
  linkAppProviders(BuildContext context) {
    _authAppModel = Provider.of<AuthAppModel>(context);
  }
}
