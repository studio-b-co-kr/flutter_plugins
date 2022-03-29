import 'package:flutter/widgets.dart';
import 'package:remedi/remedi.dart';

part 'splash_view_model.dart';

class SplashPage extends ViewModelBuilder<_SplashViewModel> {
  final String from;
  final Widget background;

  SplashPage({
    Key? key,
    required this.from,
    required this.background,
    required ISplashRepository repository,
  }) : super(
            key: key,
            viewModel: _SplashViewModel(from: from, repository: repository));

  @override
  Widget build(BuildContext context, _SplashViewModel read) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            background,
            _ErrorView(),
          ],
        ));
  }
}

class _ErrorView extends View<_SplashViewModel> {
  @override
  Widget buildChild(
      BuildContext context, _SplashViewModel watch, _SplashViewModel read) {
    return Container();
  }
}
