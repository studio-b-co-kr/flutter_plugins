import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_permission/model/app_permission.dart';
import 'package:remedi_permission/repository/i_permission_list_repository.dart';
import 'package:remedi_permission/viewmodel/i_permission_list_viewmodel.dart';

class PermissionListViewModel extends IPermissionListViewModel {
  PermissionListViewModel({IPermissionListRepository repository})
      : super(repository: repository);

  @override
  PermissionListViewState get initState => PermissionListViewState.Init;

  @override
  Future<bool> get hasError async {
    bool ret = false;

    await Future.forEach<AppPermission>(repository.permissions,
        (appPermission) async {
      PermissionStatus status = await appPermission.status;
      bool result = (status != PermissionStatus.granted &&
              status != PermissionStatus.limited) &&
          appPermission.mandatory;
      ret &= result;
    });

    return ret;
  }

  @override
  Future requestAll() async {
    await repository.requestAll();

    update(state: PermissionListViewState.Refresh);

    if (await hasError) {
      update(state: PermissionListViewState.Error);
    }
  }

  @override
  skipOrNext() async {
    if (await hasError) {
      update(state: PermissionListViewState.Error);
      return;
    }

    update(state: PermissionListViewState.Skip);
  }
}
