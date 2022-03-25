import 'package:flutter/widgets.dart';
import 'package:remedi/remedi.dart';
import 'package:remedi_splash/model/splash_error.dart';
import 'package:remedi_splash/remedi_splash.dart';
import 'package:remedi_splash/repository/i_splash_repository.dart';

part 'splash_view_model.dart';

class SplashPage extends ViewModelBuilder<_SplashViewModel> {
  final String from;
  final Widget background;

  SplashPage({
    required this.from,
    required this.background,
    required ISplashRepository repository,
  }) : super(viewModel: _SplashViewModel(from: from, repository: repository));

  @override
  Widget build(BuildContext context, _SplashViewModel read) {
    return Stack(
      children: [
        background,
        _ErrorView(),
      ],
    );
  }
}

class _ErrorView extends View<_SplashViewModel> {
  @override
  Widget buildChild(
      BuildContext context, _SplashViewModel watch, _SplashViewModel read) {
    return Container();
  }
}
