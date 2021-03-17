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
}
