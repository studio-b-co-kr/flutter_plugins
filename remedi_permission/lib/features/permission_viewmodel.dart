import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_permission/model/app_permission.dart';
import 'package:remedi_permission/repository/i_permission_repository.dart';
import 'package:remedi_permission/viewmodel/i_permission_viewmodel.dart';

class PermissionViewModel extends IPermissionViewModel {
  PermissionViewModel(AppPermission permission) : super(permission);

  @override
  PermissionViewState get initState => PermissionViewState.Init;

  @override
  IPermissionRepository get repository => throw UnimplementedError();

  @override
  requestPermission() async {
    PermissionStatus permissionStatus = await this.permission.status;

    switch (permissionStatus) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        // close permission page and back to the screen to request permission.
        return;

      case PermissionStatus.denied:
        // if the permission is mandatory to use app, keep permission page.
        var status = await permission.permission.request();
        break;

      case PermissionStatus.permanentlyDenied:
        // goto settings
        break;

      case PermissionStatus.restricted:
        // impossible to access
        break;
    }

    return;
  }
}

/// refer to below permission status.
// enum PermissionStatus {
//   /// The user granted access to the requested feature.
//   granted,
//
//   /// The user denied access to the requested feature.
//   denied,
//
//   /// The OS denied access to the requested feature. The user cannot change
//   /// this app's status, possibly due to active restrictions such as parental
//   /// controls being in place.
//   /// *Only supported on iOS.*
//   restricted,
//
//   ///User has authorized this application for limited access.
//   /// *Only supported on iOS (iOS14+).*
//   limited,
//
//   /// The user denied access to the requested feature and selected to never
//   /// again show a request for this permission. The user may still change the
//   /// permission status in the settings.
//   /// *Only supported on Android.*
//   permanentlyDenied,
// }
