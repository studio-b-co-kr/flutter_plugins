import 'package:remedi_splash/feature/splash/splash_error.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class ISplashViewModel extends IViewModel<SplashViewState> {
  final String? routeName;

  ISplashViewModel(this.routeName) : super();

  appOpen();

  afterAppOpen();

  afterForceUpdate();

  afterIntro();

  afterPermission();

  afterLogin();

  afterOnboarding();

  // Ready to show main contents.
  readyToService();

  showError(SplashError error);

  SplashError? get splashError;
}

enum SplashViewState {
  Init,
  AppOpen,
  ForceUpdate,
  Intro,
  Permission,
  Login,
  Onboarding,
  ReadyToService,
  GoContentsPage,
  Error,
}
