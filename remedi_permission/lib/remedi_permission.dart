library remedi_permission;

import 'dart:developer' as dev;

import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_permission/model/app_permission.dart';

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
