import 'package:example/app_models/auth_app_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

// ignore: must_be_immutable
class LoginStateWidget extends StatefulStateDataView<LoginState, bool> {
  LoginStateWidget({
    required GlobalKey<StatefulStateDataViewState<LoginState, bool>> key,
    required StateData<LoginState, bool> stateData,
  }) : super(key: key, stateData: stateData);

  @override
  Widget build(BuildContext context, LoginState? state, bool? data) {
    String text = '';
    switch (state) {
      case LoginState.loggedIn:
        text = 'login = $data';
        break;
      case LoginState.loading:
        text = 'Loading';
        break;
      case LoginState.loggedOut:
        text = 'login = $data';
        break;
      default:
        break;
    }
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 32),
    );
  }
}
