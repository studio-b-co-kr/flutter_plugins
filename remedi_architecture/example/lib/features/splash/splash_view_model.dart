import 'package:remedi_architecture/remedi_architecture.dart';

class SplashViewModel extends IViewModel {
  static final SplashViewModel _instance = SplashViewModel._();

  SplashViewModel._();

  factory SplashViewModel.instance() => _instance;

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
