import 'package:example/app_models/auth_app_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_flutter/remedi_flutter.dart';

class LoginButton extends ViewModelView<AuthAppModel> {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget buildChild(
      BuildContext context, AuthAppModel watch, AuthAppModel read) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 48,
      onPressed: read.loginState.state == LoginState.loading
          ? null
          : () async {
              switch (read.loginState.state) {
                case LoginState.loggedIn:
                  read.logout();
                  break;
                case LoginState.loggedOut:
                  read.login();
                  break;
                default:
                  break;
              }
            },
      color: Colors.red,
      child: _text(watch.loginState.state),
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
