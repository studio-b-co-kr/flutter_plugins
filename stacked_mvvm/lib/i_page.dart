part of 'stacked_mvvm.dart';

/// route
abstract class IPage<VM extends IViewModel> extends IWidget<VM> {
  IPage({Key? key, required VM viewModel})
      : super(key: key, viewModel: viewModel) {
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
