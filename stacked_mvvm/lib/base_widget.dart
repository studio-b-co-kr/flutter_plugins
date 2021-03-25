part of 'stacked_mvvm.dart';

abstract class BaseWidget<VM extends BaseViewModel> extends StatelessWidget {
  final VM viewModel;

  BaseWidget({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VM>.reactive(
      viewModelBuilder: () {
        dev.log("viewModelBuilder", name: "$this");
        return viewModel;
      },
      onModelReady: (model) async {
        dev.log("onModelReady", name: "$this");
        await model.init();
      },
      builder: (context, model, child) {
        dev.log("builder : child = $child", name: "$this");
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
    /// Do not update ui here.
    /// Only for route other page or show dialog.
    dev.log("onListen:${viewModel.state}", name: "$this");
  }
}
