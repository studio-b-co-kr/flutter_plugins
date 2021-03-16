import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_permission/repository/i_permission_repository.dart';
import 'package:remedi_permission/viewmodel/i_permission_viewmodel.dart';

class PermissionViewModel extends IPermissionViewModel {
  PermissionViewModel({IPermissionRepository repository})
      : super(repository: repository);

  @override
  PermissionViewState get initState => PermissionViewState.Init;

  @override
  init() async {
    await repository.init();
    _handleStatus(repository.status);
  }

  @override
  requestPermission() async {
    switch (repository.status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        // close permission page and back to the screen to request permission.
        return;

      case PermissionStatus.denied:
        // if the permission is mandatory to use app, keep permission page.
        bool a = repository.isPermanentlyDenied;
        var status = await repository.request();
        _handleStatus(status);
        break;

      case PermissionStatus.permanentlyDenied:
        // goto settings
        bool ret = await openAppSettings();
        break;

      case PermissionStatus.restricted:
        // impossible to access
        break;
    }

    return;
  }

  _handleStatus(PermissionStatus status) {
    PermissionViewState state = PermissionViewState.Denied;
    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        state = PermissionViewState.Granted;
        break;
      case PermissionStatus.denied:
        // retry request permission.
        state = PermissionViewState.Denied;
        break;
      case PermissionStatus.permanentlyDenied:
        // open setting screen.
        state = PermissionViewState.PermanentlyDenied;
        break;
      case PermissionStatus.restricted:
        state = PermissionViewState.Disabled;
        break;
    }
    update(state: state);
  }

  @override
  String get description => repository.permission.description;

  @override
  String get errorDescription => repository.permission.errorDescription;

  @override
  Widget get icon => repository.permission.icon;

  @override
  String get title => repository.permission.title;
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
