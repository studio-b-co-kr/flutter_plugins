part of 'splash_page.dart';

class _SplashViewModel extends ViewModel {
  final String from;
  final ISplashRepository repository;

  _SplashViewModel({
    required this.from,
    required this.repository,
  });

  SplashError? error;

  void appOpen() async {
    AppLog.log('appOpen', name: toString());
    try {
      await repository.appOpen();
      throw Exception();
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
    try {
      if (await repository.isCompletedIntro()) {
        afterIntro();
        return;
      }
      repository.goIntro();
    } catch (e) {
      if (e is Exception) {
        return;
      }
      if (e is Error) {
        return;
      }
    }
  }

  void afterIntro() async {
    AppLog.log('afterIntro', name: toString());
    if (await repository.isCompletedPermissionGrant()) {
      afterPermission();
      return;
    }

    repository.goPermissionAll();
  }

  void afterPermission() async {
    AppLog.log('afterPermission', name: toString());
    try {
      if (await repository.needToLogin()) {
        repository.goLogin();
        return;
      }

      afterLogin();
    } catch (e) {
      if (e is Exception) {
        return;
      }
      if (e is Error) {
        return;
      }
    }
  }

  void afterLogin() async {
    AppLog.log('afterLogin', name: toString());
    try {
      if (await repository.isCompletedOnboarding()) {
        afterOnboarding();
        return;
      }
      repository.goOnboarding();
    } catch (e) {
      if (e is Exception) {
        return;
      }
      if (e is Error) {
        return;
      }
    }
  }

  void afterOnboarding() async {
    AppLog.log('afterOnboarding', name: toString());
    try {
      repository.readyToService();
    } catch (e) {
      if (e is Exception) {
        return;
      }
      if (e is Error) {
        return;
      }
    }
  }

  @override
  initialise() {
    switch (from) {
      case RemediSplash.appOpen:
        appOpen();
        break;
      case RemediSplash.afterIntro:
        afterIntro();
        break;
      case RemediSplash.afterPermission:
        afterPermission();
        break;
      case RemediSplash.afterLogin:
        afterLogin();
        break;
      case RemediSplash.afterOnboarding:
        afterOnboarding();
        break;
    }
  }

  showError(dynamic error) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    this.error = error;
    updateUi();
  }
}
