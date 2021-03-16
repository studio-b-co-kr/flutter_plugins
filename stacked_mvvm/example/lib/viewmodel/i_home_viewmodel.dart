import 'package:stacked_mvvm/stacked_mvvm.dart';

import '../repository/i_home_repository.dart';

abstract class IHomeViewModel
    extends BaseViewModel<HomeViewState, IHomeRepository> {
  IHomeViewModel({IHomeRepository repository}) : super(repository: repository);

  int count;

  increment();
}

enum HomeViewState {
  Init,
  First,
  Second,
}
