part of 'stacked_mvvm.dart';

class ViewModelFactory<T extends IViewModel> {
  T Function() builder;

  ViewModelFactory({required this.builder});
}
