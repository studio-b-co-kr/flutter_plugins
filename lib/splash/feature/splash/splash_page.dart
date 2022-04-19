import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remedi_flutter/remedi_flutter.dart';

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
  void initUi() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    super.initUi();
  }

  @override
  void disposeUi() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    super.disposeUi();
  }

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

class _ErrorView extends ViewModelView<_SplashViewModel> {
  @override
  Widget buildChild(
      BuildContext context, _SplashViewModel watch, _SplashViewModel read) {
    if (read.error == null) {
      return Container();
    }
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 320,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(
                    Icons.error,
                    color: Colors.yellow.shade900,
                    size: 32,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Error',
                    style: TextStyle(fontSize: 24),
                  ),
                ]),
                const SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      _errorString(watch.error),
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _errorString(dynamic e) {
    if (e is Error) {
      return e.stackTrace?.toString() ?? '';
    }

    if (e is Exception) {
      return e.toString();
    }

    return '';
  }
}
