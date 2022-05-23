import 'package:flutter/material.dart';
import 'package:remedi_flutter/scenario/scenario.dart';

class SplashScene extends Scene {
  static const routeName = '/';

  const SplashScene({
    Key? key,
    required Function() onFinished,
    final ThemeData? theme,
    final ThemeData? darkTheme,
    final ThemeMode? themeMode,
  }) : super(
          key: key,
          onFinished: onFinished,
          theme: theme,
          darkTheme: darkTheme,
          themeMode: themeMode,
        );

  @override
  Route? buildCutRoute(
      RouteSettings settings, Scene scene, Widget? background) {
    Route? ret;
    switch (settings.name) {
      case TestCut.cutName:
        ret = MaterialPageRoute(
            builder: (context) => TestCut(
                  scene: this,
                  viewModel: TestCutViewModel(),
                ));
        break;
      case TestCut2.cutName:
        ret = MaterialPageRoute(
            builder: (context) => TestCut2(
                  scene: this,
                  viewModel: TestCutViewModel2(),
                ));
        break;
    }
    return ret;
  }

  @override
  String get initialRoute => TestCut.cutName;
}

class TestCut extends Cut<TestCutViewModel> {
  static const cutName = '/test1';

  TestCut({Key? key, required TestCutViewModel viewModel, required Scene scene})
      : super(key: key, viewModel: viewModel, scene: scene);

  @override
  Widget build(BuildContext context, TestCutViewModel read) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Cut'),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
              color: Colors.red,
              height: 48,
              minWidth: double.infinity,
              child: const Text('Move to next'),
              onPressed: () {
                scene.onFinished();
                // read.next(context);
              }),
        ),
      ),
    );
  }
}

class TestCutViewModel extends CutViewModel {
  @override
  Future<bool> canMoveToNext() async {
    return true;
  }

  @override
  initialise() {}

  @override
  next(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(TestCut2.cutName);
  }
}

class TestCut2 extends Cut<TestCutViewModel2> {
  static const cutName = '/test2';

  TestCut2(
      {Key? key, required TestCutViewModel2 viewModel, required Scene scene})
      : super(key: key, viewModel: viewModel, scene: scene);

  @override
  Widget build(BuildContext context, TestCutViewModel2 read) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Cut2'),
      ),
    );
  }
}

class TestCutViewModel2 extends CutViewModel {
  @override
  Future<bool> canMoveToNext() async {
    return false;
  }

  @override
  initialise() {}

  @override
  next(BuildContext context) {}
}
