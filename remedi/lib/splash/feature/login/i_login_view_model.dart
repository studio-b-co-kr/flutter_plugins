import 'package:remedi/remedi.dart';

abstract class ILoginViewModel extends ViewModel {
  void goNext() {
    RemediRouter.pushReplacementNamed(
      RemediSplash.routeName,
      arguments: RemediSplash.afterLogin,
    );
  }
}
