class PermissionManager {
  static final List<AppPermission> _appPermissionList = [];

  static List<AppPermission> get permissionList => _appPermissionList;

  static init(List<Permission> permissionList) {
    for (Permission permission in permissionList) {
      AppPermission appPermission = AppPermission(permission);
      _appPermissionList.add(appPermission);
    }
  }

  static Future<bool> get doNotShowPermissionOnSplash async =>
      await LocalStorage.instance().skipped || await allGranted;

  static Future<bool> get allGranted async {
    bool ret = true;
    await Future.forEach<AppPermission>(_appPermissionList, (permission) async {
      ret = ret && await permission.isGranted;
    });
    dev.log("allGranted = $ret", name: "PermissionManager");
    return ret;
  }
}

class RemediPermission {}
