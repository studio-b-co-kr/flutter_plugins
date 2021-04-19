library remedi_permission;

import 'dart:developer' as dev;

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
  static final List<Permission> _permissionList = [];

  static List<Permission> get permissionList => _permissionList;

  static init(List<Permission> permissionList) {
    _permissionList.addAll(permissionList);
  }

  static Future<bool> get doNotShowPermissionOnSplash async =>
      await LocalStorage.instance().skipped || await allGranted;

  static Future<bool> get allGranted async {
    bool ret = true;
    await Future.forEach<Permission>(_permissionList, (permission) async {
      PermissionStatus status = await permission.status;
      ret = ret &&
          (status == PermissionStatus.granted ||
              status == PermissionStatus.limited);
    });
    dev.log("allGranted = $ret", name: "PermissionManager");
    return ret;
  }
}
