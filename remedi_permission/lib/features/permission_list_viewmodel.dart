import 'package:remedi_permission/features/permission_repository.dart';
import 'package:remedi_permission/model/app_permission.dart';
import 'package:remedi_permission/repository/i_permission_repository.dart';
import 'package:remedi_permission/viewmodel/i_permission_list_viewmodel.dart';

class PermissionListViewModel extends IPermissionListViewModel {
  PermissionListViewModel(List<AppPermission> permissions) : super(permissions);

  @override
  PermissionListViewState get initState => PermissionListViewState.Init;

  @override
  IPermissionRepository get repository => PermissionRepository.instance;
}
