import 'package:stacked_mvvm/stacked_mvvm.dart';

import '../auth_error.dart';

abstract class ILoginViewModel extends IViewModel<LoginViewState> {
  AuthError? authError;

  ILoginViewModel() : super();

  loginWithKakao();

  loginWithApple();
}

enum LoginViewState { Idle, Loading, Success, Error }
