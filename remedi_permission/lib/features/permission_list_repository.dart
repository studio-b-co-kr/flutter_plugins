import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_permission/model/app_permission.dart';
import 'package:remedi_permission/repository/i_permission_list_repository.dart';

import '../model/app_permission.dart';

class PermissionListRepository extends IPermissionListRepository {
  PermissionListRepository(List<AppPermission> permissions)
      : super(permissions: permissions);

  @override
  bool get hasError => true;

  @override
  Future init() async {}

  @override
  Future<Map<Permission, PermissionStatus>> requestAll() async {
    Map<Permission, PermissionStatus> ret = {};
    await Future.forEach<AppPermission>(permissions, (permission) async {
      PermissionStatus status = await permission.request();
      ret.addAll({permission.permission: status});
    });
    return ret;
  }

  @override
  Future<bool> get isAllGranted async {
    bool ret = true;
    await Future.forEach<AppPermission>(permissions, (appPermission) async {
      bool ret = true;
      ret = ret && await appPermission.isGranted;
      return ret;
    });
    return ret;
  }
}
