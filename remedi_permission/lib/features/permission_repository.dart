import 'package:remedi_permission/repository/i_permission_repository.dart';

class PermissionRepository extends IPermissionRepository {
  static PermissionRepository _instance;

  static PermissionRepository get instance {
    if (_instance == null) {
      _instance = PermissionRepository._();
    }

    return _instance;
  }

  PermissionRepository._();
}
