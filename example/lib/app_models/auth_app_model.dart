import 'package:remedi_flutter/remedi_flutter.dart';

class AuthAppModel extends AppModel {
  StateData<LoginState, bool> loginState = StateData(
    state: LoginState.loggedOut,
    data: false,
  );

  AuthAppModel() : super();

  login() async {
    loginState = StateData(state: LoginState.loading);
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    loginState = StateData(state: LoginState.loggedIn, data: true);
    notifyListeners();
  }

  logout() async {
    loginState = StateData(state: LoginState.loading);
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    loginState = StateData(state: LoginState.loggedOut, data: false);
    notifyListeners();
  }

  @override
  initialise() {}
}

enum LoginState {
  loggedIn,
  loading,
  loggedOut,
}
