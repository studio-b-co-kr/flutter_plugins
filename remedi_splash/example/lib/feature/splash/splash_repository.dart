part of 'splash.dart';

class SplashRepository extends ISplashRepository {
  @override
  Future appOpen() async {}

  @override
  void goIntro() {}

  @override
  void goLogin() {}

  @override
  void goOnboarding() {}

  @override
  void goPermission() {}

  @override
  void goUpdate() {}

  @override
  Future<bool> isCompletedIntro() async {
    return true;
  }

  @override
  Future<bool> isCompletedOnboarding() async {
    return true;
  }

  @override
  Future<bool> isCompletedPermissionGrant() async {
    return true;
  }

  @override
  Future<bool> needToLogin() async {
    return true;
  }

  @override
  Future<bool> needToUpdate() async {
    return false;
  }

  @override
  Future readyToService() async {
    AppLog.log('readyToService', name: toString());
    RemediRouter.pushReplacementNamed(HomePage.routeName);
  }
}
