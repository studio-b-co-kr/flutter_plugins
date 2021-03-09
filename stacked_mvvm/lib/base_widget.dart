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
        dev.log("viewModelBuilder", name: "BaseWidget");
        return viewModel;
      },
      onModelReady: (model) {
        dev.log("onModelReady", name: "BaseWidget");
        model.init();
      },
      builder: (context, model, child) {
        dev.log("builder", name: "BaseWidget");
        try {
          Future.microtask(() => onListen(context, model));
        } catch (e) {}
        return body(context, model, child);
      },
    );
  }

  BindingView<VM> body(BuildContext context, VM viewModel, Widget child);

  @mustCallSuper
  void onListen(BuildContext context, VM viewModel) {
    dev.log("onListen:${viewModel?.state}", name: "BaseWidget");
  }
}
