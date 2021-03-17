import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_permission/model/app_permission.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPermissionListRepository extends BaseRepository {
  final List<AppPermission> permissions;

  IPermissionListRepository({this.permissions})
      : assert(permissions != null),
        assert(permissions.isNotEmpty);

  Future init();

  Future<Map<Permission, PermissionStatus>> requestAll();

  bool get hasError;
}
