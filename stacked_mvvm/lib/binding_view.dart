part of 'stacked_mvvm.dart';

/// Data binding view
abstract class BindingView<VM extends BaseViewModel>
    extends ViewModelWidget<VM> {
  BindingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, VM viewModel);
}
