part of 'splash_page.dart';

class _SplashViewModel extends ViewModel {
  final String from;
  final ISplashRepository repository;

  _SplashViewModel({
    required this.from,
    required this.repository,
  });

  dynamic error;

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
        _showError(e);
        return;
      }
      if (e is Error) {
        _showError(e);
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
        _showError(e);
        return;
      }
      if (e is Error) {
        _showError(e);
        return;
      }
    }
  }

  void afterIntro() async {
    AppLog.log('afterIntro', name: toString());
    try {
      if (await repository.isCompletedPermissionGrant()) {
        afterPermission();
        return;
      }

      repository.goPermissionAll();
    } catch (e) {
      if (e is Exception) {
        _showError(e);
        return;
      }
      if (e is Error) {
        _showError(e);
        return;
      }
    }
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
        _showError(e);
        return;
      }
      if (e is Error) {
        _showError(e);
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
        _showError(e);
        return;
      }
      if (e is Error) {
        _showError(e);
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
        _showError(e);
        return;
      }
      if (e is Error) {
        _showError(e);
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

  _showError(dynamic error) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    this.error = error;
    updateUi();
  }
}
