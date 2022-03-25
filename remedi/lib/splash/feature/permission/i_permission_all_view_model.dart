import 'package:remedi/remedi.dart';

abstract class IPermissionAllViewModel extends ViewModel {
  void goNext() {
    RemediRouter.pushReplacementNamed(
      RemediSplash.routeName,
      arguments: RemediSplash.afterPermission,
    );
  }
}
