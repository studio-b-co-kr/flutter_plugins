import 'package:remedi_mvvm/remedi_mvvm.dart';

class AuthAppModel extends ViewModel {
  bool isLogin = false;

  login() {
    isLogin = true;
    notifyListeners();
  }

  logout() {
    isLogin = false;
    notifyListeners();
  }

  @override
  init() {}
}
