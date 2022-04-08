part of 'splash.dart';

class SplashRepository extends ISplashRepository {
  const SplashRepository() : super();

  @override
  Future appOpen() async {
    await PermissionStorage.resetSkip();
  }

  @override
  Future<bool> isCompletedIntro() async {
    return false;
  }

  @override
  Future<bool> isCompletedOnboarding() async {
    return false;
  }

  @override
  Future<bool> isCompletedPermissionGrant() async {
    return false;
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
  void readyToService() {
    AppLog.log('readyToService', name: toString());
    RemediRouter.pushReplacementNamed(HomePage.routeName);
  }
}
