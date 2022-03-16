import 'package:remedi_mvvm/remedi_mvvm.dart';

class AuthAppModel extends IAppModel {
  StateData<LoginState, bool> loginState = StateData(
    state: LoginState.loggedOut,
    data: false,
  );

  AuthAppModel({bool? withInit}) : super(withInit: withInit);

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
