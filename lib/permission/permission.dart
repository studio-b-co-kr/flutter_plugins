library remedi_permission;

import 'package:remedi_flutter/permission/app_permission.dart';
import 'package:remedi_flutter/permission/data/storage.dart';

import '../app/app.dart';

export 'package:permission_handler/permission_handler.dart';

final List<AppPermission> _appPermissionList = [];

class RemediPermission {
  static init(List<AppPermission> appPermissionList) {
    _appPermissionList.addAll(appPermissionList);
  }

  static List<AppPermission> get permissionList => _appPermissionList;

  static Future<bool> get doNotShowPermissionOnSplash async =>
      await PermissionStorage.skipped || await allGranted;

  static Future<bool> get allGranted async {
    bool ret = true;
    await Future.forEach<AppPermission>(_appPermissionList, (permission) async {
      ret = ret && (await permission.loadStatus).isGranted;
    });
    AppLog.log("allGranted = $ret", name: "PermissionManager");
    return ret;
  }
}
