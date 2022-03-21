import 'package:example/app_models/auth_app_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

// ignore: must_be_immutable
class LoginButtonWidget extends IStatefulStateDataView<LoginState, bool> {
  final Function() logout;
  final Function() login;

  LoginButtonWidget({
    required GlobalKey<StatefulStateDataViewState<LoginState, bool>> key,
    required this.login,
    required this.logout,
    required StateData<LoginState, bool> stateData,
  }) : super(key: key, stateData: stateData);

  @override
  Widget build(BuildContext context, LoginState? state, bool? data) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 48,
      onPressed: state == null || state == LoginState.loading
          ? null
          : () async {
              switch (state) {
                case LoginState.loggedIn:
                  logout();
                  break;
                case LoginState.loggedOut:
                  login();
                  break;
                default:
                  break;
              }
            },
      color: Colors.red,
      child: _text(state),
    );
  }

  Widget _text(LoginState? state) {
    String text = "";
    switch (state) {
      case LoginState.loggedIn:
        text = 'LOGOUT';
        break;
      case LoginState.loading:
        text = 'LOADING';
        break;
      case LoginState.loggedOut:
        text = 'LOGIN';
        break;
      default:
        break;
    }
    return Text(text);
  }
}
