import 'package:permission_handler/permission_handler.dart';
import 'package:remedi/remedi.dart';

import '../app_permission.dart';

abstract class IPermissionListRepository extends Repository {
  final List<AppPermission> permissions;

  IPermissionListRepository({required this.permissions})
      : assert(permissions.isNotEmpty);

  Future init();

  Future<Map<Permission, PermissionStatus>> requestAll();

  bool get hasError;

  Future<bool> get isAllGranted;
}
