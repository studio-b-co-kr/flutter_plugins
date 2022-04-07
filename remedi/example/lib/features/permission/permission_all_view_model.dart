part of 'permission.dart';

class PermissionAllViewModel extends IPermissionAllViewModel {
  @override
  initialise() {
    loadStateAll();
  }

  loadStateAll() async {
    await Future.forEach<AppPermission>(RemediPermission.permissionList,
        (permission) async {
      (await permission.loadStatus);
    });
  }

  requestAll() async {
    await Future.forEach<AppPermission>(RemediPermission.permissionList,
        (permission) async {
      (await permission.request());
    });
  }

  Future<bool> get canSkipAll async {
    bool ret = true;
    for (var element in RemediPermission.permissionList) {
      if (element.shouldBeGranted) {
        ret = false;
        break;
      }
    }

    return ret;
  }
}
