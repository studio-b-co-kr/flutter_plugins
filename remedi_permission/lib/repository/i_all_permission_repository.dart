import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_permission/model/app_permission.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IAllPermissionRepository extends BaseRepository {
  final List<AppPermission> permissions;

  IAllPermissionRepository({this.permissions});

  /// to get status after construct method call;
  Future init();

  Future<PermissionStatus> request();

  Future goSettings();

  bool get isError;

  bool get isGranted;

  bool get isDenied;

  bool get isPermanentlyDenied;
}
