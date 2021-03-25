import 'dart:developer' as dev;

import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_permission/model/app_permission.dart';
import 'package:remedi_permission/repository/i_permission_list_repository.dart';
import 'package:remedi_permission/viewmodel/i_permission_list_viewmodel.dart';

class PermissionListViewModel extends IPermissionListViewModel {
  PermissionListViewModel({required IPermissionListRepository repository})
      : super(repository: repository);

  @override
  PermissionListViewState get initState => PermissionListViewState.Init;

  @override
  Future<bool> get hasError async {
    bool ret = false;

    await Future.forEach<AppPermission>(repository.permissions,
        (appPermission) async {
      await appPermission.status.then((status) => ret |=
          appPermission.mandatory &&
              !(status == PermissionStatus.granted ||
                  status == PermissionStatus.limited));
    });

    dev.log("hasError = $ret", name: "PermissionListViewModel");

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
    bool error = await hasError;
    if (error) {
      update(state: PermissionListViewState.Error);
      return;
    }

    update(state: PermissionListViewState.Skip);
  }

  @override
  Future<bool> get canSkip async =>
      !(await hasError) && !(await repository.isAllGranted);

  @override
  Future<bool> get showNext async => false;

  Future<bool> get showRequestAll async => false;
}
