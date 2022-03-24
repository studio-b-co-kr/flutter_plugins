import 'package:remedi_architecture/remedi.dart';

class SplashViewModel extends ViewModel {
  static SplashViewModel _instance = SplashViewModel._();

  SplashViewModel._();

  factory SplashViewModel.singleton() {
    if (_instance.isDisposed) {
      _instance = SplashViewModel._();
    }

    return _instance;
  }

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
