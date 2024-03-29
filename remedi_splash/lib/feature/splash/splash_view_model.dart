import 'dart:developer' as dev;

import 'package:remedi_splash/repository/i_splash_repository.dart';
import 'package:remedi_splash/view_model/i_splash_view_model.dart';

import 'splash_error.dart';
import 'splash_page.dart';

class SplashViewModel extends ISplashViewModel {
  final ISplashRepository repository;

  SplashViewModel(String? routeName, {required this.repository})
      : super(routeName);
  late SplashError _error;

  @override
  SplashError get splashError => _error;

  @override
  init() {
    super.init();
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
    if (ret is SplashError) {
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

    if (ret is SplashError) {
      _error = ret;
      update(state: SplashViewState.Error);
      return;
    }

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
    await repository.afterPermission();

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

    if (ret is SplashError) {
      if (ret.code == "401" || ret.code == "404") {
        update(state: SplashViewState.Login);
        return;
      }

      _error = ret;
      update(state: SplashViewState.Error);
      return;
    }

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

    if (ret is SplashError) {
      if (ret.code == "401" || ret.code == "404") {
        update(state: SplashViewState.Login);
        return;
      }

      _error = ret;
      update(state: SplashViewState.Error);
      return;
    }

    update(state: SplashViewState.GoContentsPage);
  }

  showError(SplashError error) async {
    dev.log("showError", name: "SplashViewModel : run");
    update(state: SplashViewState.Error);
  }

  @override
  get initState => SplashViewState.Init;
}
