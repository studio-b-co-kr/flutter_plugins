part of 'splash.dart';

class SplashRepository extends ISplashRepository {
  static final SplashRepository _instance = SplashRepository._();

  SplashRepository._();

  factory SplashRepository() {
    return _instance;
  }

  @override
  Future appOpen() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  void goIntro() {}

  @override
  void goLogin() {}

  @override
  void goOnboarding() {}

  @override
  void goPermission() {}

  @override
  Future<bool> isCompletedIntro() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  Future<bool> isCompletedOnboarding() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  Future<bool> isCompletedPermissionGrant() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  Future<bool> needToLogin() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return false;
  }

  @override
  Future<bool> needToUpdate() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  Future readyToService() async {
    AppLog.log('readyToService', name: toString());
    RemediRouter.pushReplacementNamed(HomePage.routeName);
  }
}
