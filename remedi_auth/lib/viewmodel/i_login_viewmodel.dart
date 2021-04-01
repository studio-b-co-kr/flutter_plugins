import 'package:remedi_auth/repository/i_login_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import '../auth_error.dart';

abstract class ILoginViewModel
    extends BaseViewModel<LoginViewState, ILoginRepository> {
  AuthError? error;

  ILoginViewModel({required ILoginRepository repository})
      : super(repository: repository);

  loginWithKakao();

  loginWithApple();
}

enum LoginViewState { Idle, Loading, Success, Error }
