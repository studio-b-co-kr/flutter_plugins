import 'package:remedi_splash/error/app_error.dart';
import 'package:remedi_splash/repository/i_splash_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class ISplashViewModel
    extends BaseViewModel<SplashViewState, ISplashRepository> {
  final String routeName;

  ISplashViewModel(this.routeName, {required ISplashRepository repository})
      : super(repository: repository);

  appOpen();

  afterAppOpen();

  afterForceUpdate();

  afterIntro();

  afterPermission();

  afterLogin();

  afterOnboarding();

  // Ready to show main contents.
  readyToService();

  showError(AppError error);

  AppError get error;
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
