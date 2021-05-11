part of 'stacked_mvvm.dart';

/// IView has to ui code, IWidget should be controller.
abstract class IWidget<VM extends IViewModel> extends StatelessWidget {
  final VM viewModel;

  IWidget({Key? key, required this.viewModel}) : super(key: key);

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

  IView<VM> body(BuildContext context, VM viewModel, Widget? child);

  @mustCallSuper
  void onListen(BuildContext context, VM viewModel) {
    /// Do not update ui here.
    /// Only for route other page or show dialog.
    dev.log("onListen:${viewModel.state}", name: "$this");
  }
}
