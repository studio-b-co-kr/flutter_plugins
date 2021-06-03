part of 'stacked_mvvm.dart';

class ViewModelFactory<T extends IViewModel> {
  T Function() build;

  ViewModelFactory({required this.build});
}
