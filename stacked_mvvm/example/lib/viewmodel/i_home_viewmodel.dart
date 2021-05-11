import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IHomeViewModel extends IViewModel<HomeViewState> {
  int get count;

  increment();
}

enum HomeViewState {
  Init,
  First,
  Second,
}
