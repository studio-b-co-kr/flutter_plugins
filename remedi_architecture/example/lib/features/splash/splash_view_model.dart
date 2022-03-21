import 'package:remedi_architecture/remedi_architecture.dart';

class SplashViewModel extends IViewModel {
  static SplashViewModel? _instance;

  SplashViewModel._();

  static SplashViewModel get instance {
    if (_instance?.isDisposed ?? true) {
      _instance = null;
      _instance = SplashViewModel._();
    }
    return _instance!;
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
