import 'package:flutter/widgets.dart';
import 'package:remedi/architecture/architecture.dart';
import 'package:remedi/remedi.dart';
import 'package:remedi_splash/model/splash_error.dart';
import 'package:remedi_splash/repository/i_splash_repository.dart';

part 'splash_view_model.dart';

class SplashPage extends StatelessWidget {
  final Widget background;
  final ISplashRepository repository;

  SplashPage({
    Key? key,
    required this.background,
    required this.repository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SplashPage(
      background: background,
      repository: repository,
    );
  }
}

class _SplashPage extends ViewModelBuilder<SplashViewModel> {
  final Widget background;

  _SplashPage({
    required this.background,
    required ISplashRepository repository,
  }) : super(viewModel: SplashViewModel(repository: repository));

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
