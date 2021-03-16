import 'package:remedi_permission/model/app_permission.dart';
import 'package:remedi_permission/repository/i_all_permission_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPermissionListViewModel
    extends BaseViewModel<PermissionListViewState, IAllPermissionRepository> {
  final List<AppPermission> permissions;

  IPermissionListViewModel(this.permissions) {
    assert(permissions != null);
    assert(permissions.isNotEmpty);
  }
}

enum PermissionListViewState { Init }
