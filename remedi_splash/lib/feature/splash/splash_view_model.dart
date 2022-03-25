part of 'splash_page.dart';

class _SplashViewModel extends ViewModel {
  final String route;
  final ISplashRepository repository;

  _SplashViewModel({
    required this.route,
    required this.repository,
  });

  SplashError? error;

  void appOpen() async {
    AppLog.log('appOpen', name: toString());
    try {
      await repository.appOpen();
      if (await repository.needToUpdate()) {
        repository.goUpdate();
        return;
      }
      afterAppOpen();
    } catch (e) {
      if (e is Exception) {
        return;
      }
      if (e is Error) {
        return;
      }
    }
  }

  void afterAppOpen() async {
    AppLog.log('afterAppOpen', name: toString());
    if (await repository.isCompletedIntro()) {
      afterIntro();
      return;
    }
    repository.goIntro();
  }

  void afterIntro() async {
    AppLog.log('afterIntro', name: toString());
    if (await repository.isCompletedPermissionGrant()) {
      afterPermission();
      return;
    }

    repository.goPermission();
  }

  void afterPermission() async {
    AppLog.log('afterPermission', name: toString());
    if (await repository.needToLogin()) {
      repository.goLogin();
      return;
    }

    afterLogin();
  }

  void afterLogin() async {
    AppLog.log('afterLogin', name: toString());
    if (await repository.isCompletedOnboarding()) {
      afterOnboarding();
      return;
    }
    repository.goOnboarding();
  }

  void afterOnboarding() async {
    AppLog.log('afterOnboarding', name: toString());
    await repository.readyToService();
  }

  @override
  initialise() {
    appOpen();
  }
}
