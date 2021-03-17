import 'package:remedi_permission/repository/i_permission_list_repository.dart';
import 'package:remedi_permission/viewmodel/i_permission_list_viewmodel.dart';

class PermissionListViewModel extends IPermissionListViewModel {
  PermissionListViewModel({IPermissionListRepository repository})
      : super(repository: repository);

  @override
  PermissionListViewState get initState => PermissionListViewState.Init;

  @override
  // TODO: implement hasError
  bool get hasError {
    return false;
  }

  @override
  Future requestAll() async {
    await repository.requestAll();

    // TODO refresh all list
    update(state: PermissionListViewState.Refresh);

    if (false) {
      update(state: PermissionListViewState.Error);
    }
  }
}
