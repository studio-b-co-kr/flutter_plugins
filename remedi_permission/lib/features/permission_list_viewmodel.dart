import 'dart:developer' as dev;

import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_permission/model/app_permission.dart';
import 'package:remedi_permission/remedi_permission.dart';
import 'package:remedi_permission/repository/i_permission_list_repository.dart';
import 'package:remedi_permission/viewmodel/i_permission_list_viewmodel.dart';

class PermissionListViewModel extends IPermissionListViewModel {
  PermissionListViewModel({required IPermissionListRepository repository})
      : super(repository: repository);

  @override
  PermissionListViewState get initState => PermissionListViewState.Init;

  @override
  init() async {
    hasError = await checkError;
    update();
  }

  @override
  Future<bool> get checkError async {
    bool ret = false;

    await Future.forEach<AppPermission>(repository.permissions,
        (appPermission) async {
      await appPermission.status.then((status) => ret |=
          appPermission.mandatory &&
              !(status == PermissionStatus.granted ||
                  status == PermissionStatus.limited));
    });

    dev.log("checkError = $ret", name: "PermissionListViewModel");

    return ret;
  }

  @override
  Future requestAll() async {
    await repository.requestAll();

    update(state: PermissionListViewState.Refresh);

    if (hasError = await checkError) {
      update(state: PermissionListViewState.Error);
    }

    if (await PermissionManager.allGranted) {
      update(state: PermissionListViewState.AllGranted);
    }
  }

  @override
  Future refresh() async {
    if (await repository.isAllGranted) {
      update(state: PermissionListViewState.AllGranted);
    }
  }

  @override
  skipOrNext() async {
    hasError = await checkError;
    if (hasError) {
      update(state: PermissionListViewState.Error);
      return;
    }

    update(state: PermissionListViewState.Skip);
  }

  @override
  Future<bool> get canSkip async =>
      !(await checkError) && !(await repository.isAllGranted);

  @override
  Future<bool> get showNext async => false;

  Future<bool> get showRequestAll async => false;
}
