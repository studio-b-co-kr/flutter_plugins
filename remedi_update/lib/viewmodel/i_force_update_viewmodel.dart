import 'package:remedi_update/repository/i_force_update_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IForceUpdateViewModel
    extends BaseViewModel<ForceUpdateViewState, IForceUpdateRepository> {
  IForceUpdateRepository repo;

  IForceUpdateViewModel({this.repo}) : assert(repo != null);

  goToUpdate();

  @override
  ForceUpdateViewState get initState => ForceUpdateViewState.Init;

  @override
  IForceUpdateRepository get repository => repo;
}

enum ForceUpdateViewState { Init }
