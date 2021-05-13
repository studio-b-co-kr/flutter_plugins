part of 'stacked_mvvm.dart';

/// Data binding view
abstract class IView<VM extends IViewModel> extends ViewModelWidget<VM> {
  IView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, VM viewModel);
}
