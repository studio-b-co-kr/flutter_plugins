import 'dart:developer' as dev;

import 'package:remedi_base/errors/app_error.dart';
import 'package:remedi_splash/repository/i_splash_repository.dart';
import 'package:remedi_splash/view_model/i_splash_view_model.dart';

import 'splash_page.dart';

class SplashViewModel extends ISplashViewModel {
  SplashViewModel(String? routeName, {required ISplashRepository repository})
      : super(routeName, repository: repository);
  late AppError _error;

  @override
  AppError get error => _error;

  init() {
    dev.log(routeName ?? "", name: "SplashViewModel Started by");
    switch (routeName) {
      case SplashPage.ROUTE_NAME_AFTER_INTRO:
        afterIntro();
        break;
      case SplashPage.ROUTE_NAME_AFTER_PERMISSION:
        afterPermission();
        break;
      case SplashPage.ROUTE_NAME_AFTER_LOGIN:
        afterLogin();
        break;
      case SplashPage.ROUTE_NAME_AFTER_ONBOARDING:
        afterOnboarding();
        break;
      case SplashPage.ROUTE_NAME_APP_OPEN:
      default:
        appOpen();
        break;
    }
  }

  @override
  appOpen() async {
    dev.log("appOpen", name: "SplashViewModel : run");
    var ret = await repository.init();
    if (ret is AppError) {
      _error = ret;
      update(state: SplashViewState.Error);
      return;
    }

    afterAppOpen();
  }

  @override
  afterAppOpen() async {
    dev.log("afterAppOpen", name: "SplashViewModel : run");
    var ret = await repository.needToUpdate();

    if (ret) {
      update(state: SplashViewState.ForceUpdate);
      return;
    }

    afterForceUpdate();
  }

  @override
  afterForceUpdate() async {
    dev.log("afterForceUpdate", name: "SplashViewModel : run");
    var ret = await repository.isCompletedIntro();
    if (ret) {
      afterIntro();
      return;
    }

    update(state: SplashViewState.Intro);
  }

  @override
  afterIntro() async {
    dev.log("afterIntro", name: "SplashViewModel : run");
    var ret = await repository.isCompletedPermissionGrant();
    if (ret) {
      afterPermission();
      return;
    }

    update(state: SplashViewState.Permission);
  }

  @override
  afterPermission() async {
    dev.log("afterPermission", name: "SplashViewModel : run");
    var ret = await repository.isLoggedIn();
    if (ret) {
      afterLogin();
      return;
    }

    update(state: SplashViewState.Login);
  }

  @override
  afterLogin() async {
    dev.log("afterLogin", name: "SplashViewModel : run");
    var ret = await repository.isCompletedOnboarding();
    if (ret) {
      afterOnboarding();
      return;
    }

    update(state: SplashViewState.Onboarding);
  }

  @override
  afterOnboarding() async {
    dev.log("afterOnboarding", name: "SplashViewModel : run");
    readyToService();
  }

  @override
  readyToService() async {
    dev.log("readyToService", name: "SplashViewModel : run");
    var ret = await repository.readyToService();

    if (ret is AppError) {
      _error = ret;
      update(state: SplashViewState.Error);
      return;
    }

    update(state: SplashViewState.GoContentsPage);
  }

  showError(AppError error) async {
    dev.log("showError", name: "SplashViewModel : run");
    update(state: SplashViewState.Error);
  }

  @override
  get initState => SplashViewState.Init;
}
