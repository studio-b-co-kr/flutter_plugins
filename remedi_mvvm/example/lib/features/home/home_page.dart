import 'package:example/features/home/home_view_model.dart';
import 'package:example/providers/auth_app_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class HomePage extends ViewModelView<HomeViewModel> {
  static const routeName = '/home';

  const HomePage({Key? key, required HomeViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      backgroundColor: viewModel.deeplinkAppModel.color,
      appBar: AppBar(
        title: const Text('MVVM Example'),
      ),
      body: Column(children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginStatusWidget(stateData: viewModel.loginState),
                CountWidget(data: viewModel.count),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: LoginButtonWidget(
            login: () {
              viewModel.authAppModel.login();
            },
            logout: () {
              viewModel.authAppModel.logout();
            },
            stateData: viewModel.loginState,
          ),
        ),
      ]),
    );
  }
}

class LoginButtonWidget extends StateView<LoginState, bool> {
  final Function() logout;
  final Function() login;

  const LoginButtonWidget({
    Key? key,
    required this.login,
    required this.logout,
    required StateData<LoginState, bool> stateData,
  }) : super(key: key, stateData: stateData);

  @override
  Widget buildWidget(BuildContext context, LoginState? state, bool? data) {
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

class LoginStatusWidget extends StateView<LoginState, bool> {
  const LoginStatusWidget({
    Key? key,
    required StateData<LoginState, bool> stateData,
  }) : super(key: key, stateData: stateData);

  @override
  Widget buildWidget(BuildContext context, LoginState? state, bool? data) {
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

class CountWidget extends View<int> {
  const CountWidget({Key? key, required int data})
      : super(key: key, data: data);

  @override
  Widget buildWidget(BuildContext context, int? data) {
    return Text(
      '$data',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 40),
    );
  }
}
