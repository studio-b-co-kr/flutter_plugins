part of 'splash.dart';

class SplashRepository extends ISplashRepository {
  static final SplashRepository _instance = SplashRepository._();

  SplashRepository._();

  factory SplashRepository() {
    return _instance;
  }

  bool completedIntro = false;

  @override
  Future appOpen() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<bool> isCompletedIntro() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return completedIntro;
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
    return false;
  }

  @override
  Future readyToService() async {
    AppLog.log('readyToService', name: toString());
    RemediRouter.pushReplacementNamed(HomePage.routeName);
  }
}
