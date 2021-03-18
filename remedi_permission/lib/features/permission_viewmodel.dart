import 'dart:developer' as dev;

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
    PermissionStatus status;
    switch (repository.status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        // close permission page and back to the screen to request permission.
        return;
      case PermissionStatus.denied:
        // if the permission is mandatory to use app, keep permission page.
        status = await repository.request();
        break;

      case PermissionStatus.permanentlyDenied:
        // goto settings
        bool ret = await openAppSettings();
        if (ret) {
          status = await repository.readPermissionStatus();
        }
        break;

      case PermissionStatus.restricted:
        // impossible to access
        break;
    }

    _handleStatus(status);

    return;
  }

  _handleStatus(PermissionStatus status) async {
    if (status == null) {
      return;
    }
    PermissionViewState state = PermissionViewState.Denied;
    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        state = PermissionViewState.Granted;

        break;
      case PermissionStatus.denied:
        if (repository.permission.mandatory) {
          state = PermissionViewState.Error;
        } else {
          state = PermissionViewState.Denied;
        }
        break;
      case PermissionStatus.permanentlyDenied:
        if (repository.permission.mandatory) {
          state = PermissionViewState.Error;
        } else {
          state = PermissionViewState.PermanentlyDenied;
        }
        break;
      case PermissionStatus.restricted:
        state = PermissionViewState.Disabled;
        break;
    }
    if (repository.permission.permission.value == Permission.camera.value) {
      dev.log("${repository.permission.permission}", name: "HANDLE_STATUS");
      dev.log("${await repository.permission.permission.status}",
          name: "HANDLE_STATUS");
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

  @override
  String get statusMessage {
    String ret = "";
    switch (state) {
      case PermissionViewState.Granted:
      case PermissionViewState.Limited:
        ret = "Granted!";
        break;
      case PermissionViewState.Denied:
      case PermissionViewState.PermanentlyDenied:
        ret = "Please grant this permission";
        break;
      case PermissionViewState.Error:
        ret = errorDescription;
        break;
      case PermissionViewState.Disabled:
      case PermissionViewState.Init:
      case PermissionViewState.Restricted:
        ret = "Not possible";
        break;
      default:
        break;
    }
    return ret;
  }

  @override
  Future refresh() async {
    PermissionStatus status = await repository.readPermissionStatus();
    _handleStatus(status);
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
