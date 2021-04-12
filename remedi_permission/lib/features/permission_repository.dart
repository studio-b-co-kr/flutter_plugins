import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_permission/model/app_permission.dart';
import 'package:remedi_permission/repository/i_permission_repository.dart';

import '../model/app_permission.dart';
import '../repository/i_permission_repository.dart';

class PermissionRepository extends IPermissionRepository {
  PermissionRepository(AppPermission permission)
      : super(permission: permission);

  @override
  Future init() async {
    await readPermissionStatus();
  }

  @override
  bool get isDenied =>
      (status?.isDenied ?? false) || (status?.isRestricted ?? false);

  @override
  bool get isError => !isGranted && permission.mandatory;

  @override
  bool get isGranted =>
      (status?.isGranted ?? true) || (status?.isLimited ?? true);

  @override
  bool get isPermanentlyDenied => status?.isPermanentlyDenied ?? false;

  @override
  Future<PermissionStatus> request() async {
    return status = await permission.permission.request();
  }

  @override
  Future<PermissionStatus> readPermissionStatus() async {
    return status = await permission.permission.status;
  }
}
