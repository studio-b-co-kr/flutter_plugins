import 'package:flutter/widgets.dart';
import 'package:remedi/architecture/architecture.dart';
import 'package:remedi/remedi.dart';
import 'package:remedi_splash/repository/i_splash_repository.dart';

part 'splash_view_model.dart';

class SplashPage extends ViewModelBuilder<SplashViewModel> {
  static const routeNameAppOpen = "/splash/app_open";
  static const routeNameAfterIntro = "/splash/after_intro";
  static const routeNameAfterPermission = "/splash/after_permission";
  static const routeNameAfterLogin = "/splash/after_login";
  static const routeNameAfterOnboarding = "/splash/after_onboarding";

  final Widget background;

  SplashPage({
    Key? key,
    required this.background,
    required SplashViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, SplashViewModel read) {
    return Stack(
      children: [
        background,
        _ErrorView(),
      ],
    );
  }
}

class _ErrorView extends View<SplashViewModel> {
  @override
  Widget buildChild(
      BuildContext context, SplashViewModel watch, SplashViewModel read) {
    return Container();
  }
}
