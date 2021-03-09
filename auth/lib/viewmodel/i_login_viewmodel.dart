import 'package:remedi_flutter_plugin_auth/repository/i_login_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import '../auth_error.dart';

abstract class ILoginViewModel
    extends BaseViewModel<LoginViewState, ILoginRepository> {
  final ILoginRepository repo;
  AuthError error;

  ILoginViewModel({this.repo}) : super();

  loginWithKakao();

  loginWithApple();

  @override
  ILoginRepository get repository => repo;
}

enum LoginViewState { Idle, Loading, Success, Error }
