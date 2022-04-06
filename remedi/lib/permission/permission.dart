library remedi_permission;

import 'dart:developer' as dev;

import 'package:remedi/permission/app_permission.dart';
import 'package:remedi/permission/data/storage.dart';
import 'package:remedi/remedi.dart';

export 'package:permission_handler/permission_handler.dart';

final List<AppPermission> _appPermissionList = [];

class RemediPermission {
  static init(List<AppPermission> appPermissionList) {
    _appPermissionList.addAll(permissionList);
  }

  static List<AppPermission> get permissionList => _appPermissionList;

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

class RemediPermissionAppModel extends AppModel {
  @override
  initialise() {
    loadStateAll();
  }

  loadStateAll() async {
    await Future.forEach<AppPermission>(_appPermissionList, (permission) async {
      (await permission.loadStatus);
    });
  }

  requestAll() async {
    await Future.forEach<AppPermission>(_appPermissionList, (permission) async {
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
