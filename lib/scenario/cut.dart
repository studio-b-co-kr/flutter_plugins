part of 'scenario.dart';

abstract class Cut<VM extends CutViewModel> extends ViewModelBuilder<VM> {
  final Scene scene;
  final Widget? background;

  Cut({
    Key? key,
    required final VM viewModel,
    required this.scene,
    this.background,
  }) : super(key: key, viewModel: viewModel);

  finishScene() {
    scene.onFinished();
  }

  next();

  bool canMoveToNext();

  @override
  Widget build(BuildContext context, VM read);
}

abstract class CutViewModel extends ViewModel {
  next();

  bool canMoveToNext();
}
