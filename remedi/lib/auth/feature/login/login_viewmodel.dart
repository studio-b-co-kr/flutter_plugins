import 'package:remedi/auth/repository/i_login_repository.dart';

import '../../../remedi.dart';

class LoginViewModel extends ViewModel {
  @override
  initialise() {}
  final ILoginRepository repository;

  LoginViewModel({required this.repository}) : super();
}
