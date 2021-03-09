import 'package:stacked_mvvm/stacked_mvvm.dart';

import '../repository/i_home_repository.dart';

abstract class IHomeViewModel
    extends BaseViewModel<HomeViewState, IHomeRepository> {
  int count;

  increment();
}

enum HomeViewState {
  Init,
  First,
  Second,
}
