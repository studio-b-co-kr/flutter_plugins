import 'package:remedi_mvvm/remedi_mvvm.dart';

class SplashViewModel extends ViewModel {
  next() async {
    await Future.delayed(const Duration(seconds: 3));
    updateAction(SplashAction.goHome);
  }

  @override
  initialise() {
    next();
  }
}

enum SplashAction {
  goHome,
}
