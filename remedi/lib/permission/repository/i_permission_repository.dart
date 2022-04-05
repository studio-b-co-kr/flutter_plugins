import 'package:permission_handler/permission_handler.dart';
import 'package:remedi/remedi.dart';

import '../app_permission.dart';
// import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPermissionRepository extends Repository {
  final AppPermission permission;
  PermissionStatus? status;

  IPermissionRepository({required this.permission}) {
    Future.microtask(() async => status = await permission.permission.status);
  }

  /// to get status after construct method call;
  Future init();

  Future<PermissionStatus> request();

  bool get isError;

  bool get isGranted;

  bool get isDenied;

  bool get isPermanentlyDenied;

  Future<PermissionStatus> readPermissionStatus();
}
