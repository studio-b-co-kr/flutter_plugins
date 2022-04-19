import 'package:remedi_flutter/remedi_flutter.dart';

abstract class ILoginViewModel extends ViewModel {
  void goNext() {
    RemediRouter.pushReplacementNamed(
      RemediSplash.routeName,
      arguments: RemediSplash.afterLogin,
    );
  }
}
