library remedi_permission;

import 'dart:developer' as dev;

import 'package:remedi/permission/app_permission.dart';
import 'package:remedi/permission/data/storage.dart';

export 'package:permission_handler/permission_handler.dart';

final List<AppPermission> _appPermissionList = [];

class RemediPermission {
  static List<AppPermission> get permissionList => _appPermissionList;

  static init(List<AppPermission> permissionList) {
    _appPermissionList.addAll(permissionList);
  }

  static Future<bool> get doNotShowPermissionOnSplash async =>
      await PermissionStorage.skipped || await allGranted;

  static Future<bool> get allGranted async {
    bool ret = true;
    await Future.forEach<AppPermission>(_appPermissionList, (permission) async {
      ret = ret && (await permission.loadStatus).isGranted;
    });
    dev.log("allGranted = $ret", name: "PermissionManager");
    return ret;
  }
}
