import 'package:flutter/foundation.dart';

import '../../repository/i_home_repository.dart';
import '../../viewmodel/i_home_viewmodel.dart';

class HomeViewModel extends IHomeViewModel {
  int _count = 0;

  HomeViewModel({IHomeRepository repository}) : super(repository: repository);

  int get count => _count;

  void increment() {
    _count++;
    update(state: HomeViewState.First);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }

  @override
  get initState => HomeViewState.Init;

  @override
  init() {}
}
