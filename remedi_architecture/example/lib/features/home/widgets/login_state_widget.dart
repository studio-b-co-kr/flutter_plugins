import 'package:example/app_models/auth_app_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/mvvm/view_model_widget.dart';

class LoginStateWidget extends ProviderWidget<AuthAppModel> {
  const LoginStateWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(
      BuildContext context, AuthAppModel watch, AuthAppModel read) {
    String text = '';
    switch (read.loginState.state) {
      case LoginState.loggedIn:
        text = 'login = ${watch.loginState.data}';
        break;
      case LoginState.loading:
        text = 'Loading';
        break;
      case LoginState.loggedOut:
        text = 'login = ${watch.loginState.data}';
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
