import 'package:remedi/permission/app_permission.dart';
import 'package:remedi/remedi.dart';

class PermissionListViewModel extends ViewModel {
  final List<AppPermission> permissionList;

  PermissionListViewModel({required this.permissionList});

  @override
  initialise() {
    loadStateAll();
  }

  loadStateAll() async {
    await Future.forEach<AppPermission>(permissionList, (permission) async {
      (await permission.loadStatus);
    });

    updateUi();
  }

  requestAll() async {
    await Future.forEach<AppPermission>(permissionList, (permission) async {
      (await permission.request());
    });
  }

  Future<bool> get canSkipAll async {
    bool ret = true;
    for (var element in permissionList) {
      if (element.shouldBeGranted) {
        ret = false;
        break;
      }
    }

    return ret;
  }
}
