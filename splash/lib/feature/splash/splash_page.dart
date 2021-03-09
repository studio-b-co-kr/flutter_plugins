import 'package:flutter/widgets.dart';
import 'package:remedi_flutter_plugin_splash/view_model/i_splash_view_model.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import '../../ui/splash_ui.dart';
import 'splash_view.dart';

class SplashPage extends BasePage<ISplashViewModel> implements SplashUi {
  static const ROUTE_NAME_APP_OPEN = "/";
  static const ROUTE_NAME_AFTER_INTRO = "/after_intro";
  static const ROUTE_NAME_AFTER_PERMISSION = "/after_permission";
  static const ROUTE_NAME_AFTER_LOGIN = "/after_login";
  static const ROUTE_NAME_AFTER_ONBOARDING = "/after_onboarding";

  final String forceUpdatePageRouteName;
  final String permissionPageRouteName;
  final String loginPageRouteName;
  final String introPageRouteName;
  final String onBoardingPageRouteName;
  final String contentsPageRouteName;
  final String imageLogoCompany;
  final String imageLogoApp;

  SplashPage({
    Key key,
    this.forceUpdatePageRouteName,
    this.permissionPageRouteName,
    this.loginPageRouteName,
    this.introPageRouteName,
    this.onBoardingPageRouteName,
    this.contentsPageRouteName,
    this.imageLogoApp,
    this.imageLogoCompany,
    ISplashViewModel viewModel,
  })  : assert(contentsPageRouteName != null),
        super(key: key, viewModel: viewModel);

  @override
  String get screenName => "splash";

  @override
  Future logScreenOpen(String screenName) async {}

  @override
  onListen(BuildContext context, ISplashViewModel viewModel) async {
    super.onListen(context, viewModel);
    switch (viewModel.state) {
      case SplashViewState.AppOpen:
        break;
      case SplashViewState.Login:
        if (loginPageRouteName != null && loginPageRouteName.contains('/')) {
          Navigator.of(context).pushReplacementNamed(loginPageRouteName);
          return;
        }
        viewModel.afterLogin();
        break;
      case SplashViewState.Onboarding:
        if (onBoardingPageRouteName != null &&
            onBoardingPageRouteName.contains('/')) {
          Navigator.of(context).pushReplacementNamed(onBoardingPageRouteName);
          return;
        }
        viewModel.afterOnboarding();
        break;
      case SplashViewState.Permission:
        if (permissionPageRouteName != null &&
            permissionPageRouteName.contains('/')) {
          Navigator.of(context).pushNamed(permissionPageRouteName);
          return;
        }
        viewModel.afterPermission();
        break;
      case SplashViewState.Intro:
        if (introPageRouteName != null && introPageRouteName.contains('/')) {
          Navigator.of(context).pushReplacementNamed(introPageRouteName);
          return;
        }
        viewModel.afterIntro();
        break;
      case SplashViewState.Error:
        break;
      case SplashViewState.ForceUpdate:
        if (forceUpdatePageRouteName != null &&
            forceUpdatePageRouteName.contains('/')) {
          Navigator.of(context).pushReplacementNamed(forceUpdatePageRouteName);
          return;
        }
        viewModel.afterForceUpdate();
        break;
      case SplashViewState.ReadyToService:
        break;
      case SplashViewState.GoContentsPage:
        goContentsPage(context);
        break;
      case SplashViewState.Init:
        break;
    }
  }

  @override
  goContentsPage(BuildContext buildContext) {
    Navigator.of(buildContext).pushReplacementNamed(this.contentsPageRouteName);
  }

  @override
  BindingView<ISplashViewModel> body(
      BuildContext context, ISplashViewModel viewModel, Widget child) {
    return SplashView(
      logoBrand: imageLogoApp,
      logoCompany: imageLogoCompany,
    );
  }
}
