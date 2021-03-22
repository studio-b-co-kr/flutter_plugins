part of 'stacked_mvvm.dart';

/// route
abstract class BasePage<VM extends BaseViewModel> extends BaseWidget<VM> {
  BasePage({Key key, VM viewModel}) : super(key: key, viewModel: viewModel) {
    onCreated();
  }

  @mustCallSuper
  onCreated() async {
    dev.log("onCreated", name: "BasePage:$key");
    logScreenOpen(screenName);
  }

  Future logScreenOpen(String screenName);

  String get screenName;
}
