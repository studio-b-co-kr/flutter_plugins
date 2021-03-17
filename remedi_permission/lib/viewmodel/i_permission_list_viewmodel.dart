import 'package:remedi_permission/repository/i_permission_list_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPermissionListViewModel
    extends BaseViewModel<PermissionListViewState, IPermissionListRepository> {
  IPermissionListViewModel({IPermissionListRepository repository})
      : super(repository: repository);

  Future<dynamic> requestAll();

  bool get hasError;
}

enum PermissionListViewState { Init, Refresh, Error }
