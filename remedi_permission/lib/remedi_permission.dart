library remedi_permission;

import 'package:permission_handler/permission_handler.dart';

import 'data/local_storage.dart';

export 'package:permission_handler/permission_handler.dart';

export 'features/permission_list_page.dart';
export 'features/permission_list_repository.dart';
export 'features/permission_list_viewmodel.dart';
export 'features/permission_page.dart';
export 'features/permission_repository.dart';
export 'features/permission_viewmodel.dart';
export 'model/app_permission.dart';

class PermissionManager {
  static List<Permission> _permissionList;

  static List<Permission> get permissionList => _permissionList;

  static init(List<Permission> permissionList) {}

  static Future<bool> get doNotShowPermissionOnSplash async =>
      await LocalStorage.instance.skipped || await allGranted;

  static Future<bool> get allGranted async {
    bool ret = true;
    await Future.forEach(_permissionList, (appPermission) async {
      PermissionStatus status = await appPermission.permission.request;
      ret &= !(status == PermissionStatus.granted ||
          status == PermissionStatus.limited);
    });

    return ret;
  }
}
