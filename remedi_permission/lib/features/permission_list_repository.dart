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
    return await List<Permission>.of(permissions.map((e) => e.permission))
        .request();
  }

  @override
  Future<bool> get isAllGranted async {
    bool ret = true;
    await Future.forEach<AppPermission>(permissions, (appPermission) async {
      await appPermission.status.then((status) {
        ret = ret &&
            (status == PermissionStatus.granted ||
                status == PermissionStatus.limited);
      });
    });
    return ret;
  }
}
