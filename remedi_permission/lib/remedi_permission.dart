library remedi_permission;

import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart';

export 'features/permission_list_page.dart';
export 'features/permission_list_repository.dart';
export 'features/permission_list_viewmodel.dart';
export 'features/permission_page.dart';
export 'features/permission_repository.dart';
export 'features/permission_viewmodel.dart';
export 'model/app_permission.dart';

class PermissionManager {
  static List<Permission> _permissionList;

  static List<Permission> get permissionList => _permissionList;

  static init(List<Permission> permissionList) {}
}
