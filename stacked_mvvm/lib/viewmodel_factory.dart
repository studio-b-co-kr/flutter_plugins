part of 'stacked_mvvm.dart';

abstract class ViewModelFactory<T extends IViewModel> {
  T build();
}
