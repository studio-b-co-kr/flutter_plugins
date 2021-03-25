import 'package:remedi_update/repository/i_force_update_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IForceUpdateViewModel
    extends BaseViewModel<ForceUpdateViewState, IForceUpdateRepository> {
  IForceUpdateViewModel({required IForceUpdateRepository repository})
      : super(repository: repository);

  goToUpdate();

  @override
  ForceUpdateViewState get initState => ForceUpdateViewState.Init;
}

enum ForceUpdateViewState { Init }
