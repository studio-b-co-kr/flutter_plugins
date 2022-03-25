import 'package:remedi/remedi.dart';
import 'package:remedi_splash/feature/force_update/force_update_wrapper.dart';

abstract class ISplashRepository extends Repository {
  Future<dynamic> appOpen();

  Future<bool> needToUpdate();

  void goUpdate() {
    RemediRouter.pushReplacementNamed(ForceUpdateWrapper.routeName);
  }

  Future<bool> isCompletedIntro();

  void goIntro();

  Future<bool> isCompletedPermissionGrant();

  void goPermission();

  Future<bool> needToLogin();

  void goLogin();

  Future<bool> isCompletedOnboarding();

  void goOnboarding();

  Future<dynamic> readyToService();
}
