import 'dart:developer' as dev;

import '../../repository/i_home_repository.dart';
import '../../viewmodel/i_home_viewmodel.dart';

class HomeViewModel extends IHomeViewModel {
  final IHomeRepository repository;
  int _count = 0;

  HomeViewModel({required this.repository}) : super();

  @override
  int get count => _count;

  void increment() {
    _count++;
    update(state: HomeViewState.First);
  }

  @override
  get initState => HomeViewState.Init;

  @override
  init() {
    dev.log("count = $_count", name: "HomeViewModel");
    super.init();
  }
}
