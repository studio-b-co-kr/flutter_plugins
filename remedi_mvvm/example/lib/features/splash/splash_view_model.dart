import 'package:example/features/home/home_page.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class SplashViewModel extends ViewModel {
  next() async {
    await Future.delayed(const Duration(seconds: 1));
    RemediRouter.pushReplacementNamed(HomePage.routeName);
  }

  @override
  init() {
    next();
  }
}

enum SplashAction {
  goHome,
}
