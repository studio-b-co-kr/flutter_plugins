import '../../remedi.dart';
import '../auth_error.dart';

abstract class ILoginViewModel extends ViewModel {
  AuthError? authError;

  ILoginViewModel() : super();

  loginWithKakao();

  loginWithApple();
}

enum LoginViewState {
  idle,
  loading,
  success,
  error,
}
