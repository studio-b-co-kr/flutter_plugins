part of 'stacked_mvvm.dart';

abstract class BaseWidget<VM extends BaseViewModel> extends StatelessWidget {
  final VM viewModel;

  BaseWidget({Key key, this.viewModel})
      : assert(viewModel != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VM>.reactive(
      viewModelBuilder: () {
        dev.log("viewModelBuilder", name: "$this");
        return viewModel;
      },
      onModelReady: (model) {
        dev.log("onModelReady", name: "$this");
        onListen(context, model);
        model.init();
      },
      builder: (context, model, child) {
        dev.log("builder", name: "$this");
        return body(context, model, child);
      },
    );
  }

  BindingView<VM> body(BuildContext context, VM viewModel, Widget child);

  @mustCallSuper
  void onListen(BuildContext context, VM viewModel) {
    dev.log("onListen:${viewModel?.state}", name: "$this");
  }
}
