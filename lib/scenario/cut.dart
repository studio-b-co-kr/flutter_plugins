part of 'scenario.dart';

abstract class Cut<VM extends CutViewModel> extends ViewModelBuilder<VM> {
  final Scene scene;
  final Widget? splashWidget;

  Cut({
    Key? key,
    required final VM viewModel,
    required this.scene,
    this.splashWidget,
  }) : super(key: key, viewModel: viewModel);

  finishScene() {
    scene.onFinished();
  }
}

abstract class CutViewModel extends ViewModel {
  next(BuildContext context);

  Future<bool> canMoveToNext();
}
