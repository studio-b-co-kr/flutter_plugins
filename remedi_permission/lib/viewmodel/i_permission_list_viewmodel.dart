import 'package:remedi_permission/repository/i_permission_list_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPermissionListViewModel
    extends BaseViewModel<PermissionListViewState, IPermissionListRepository> {
  IPermissionListViewModel({IPermissionListRepository repository})
      : super(repository: repository);

  Future<dynamic> requestAll();

  Future<bool> get hasError;

  skipOrNext();
}

enum PermissionListViewState { Init, Refresh, Error, Skip }
