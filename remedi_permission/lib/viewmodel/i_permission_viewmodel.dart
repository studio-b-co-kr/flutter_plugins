import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_permission/repository/i_permission_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPermissionViewModel
    extends BaseViewModel<PermissionViewState, IPermissionRepository> {
  IPermissionViewModel({IPermissionRepository repository})
      : super(repository: repository);

  Future<PermissionStatus> requestPermission();

  Future<dynamic> refresh();

  String get title;

  String get description;

  String get errorDescription;

  Widget get icon;

  String get statusMessage;
}

enum PermissionViewState {
  Init,

  /// The user granted access to the requested feature.
  Granted,

  /// The user denied access to the requested feature.
  Denied,

  /// The OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  /// *Only supported on iOS.*
  Restricted,

  ///User has authorized this application for limited access.
  /// *Only supported on iOS (iOS14+).*
  Limited,

  /// The user denied access to the requested feature and selected to never
  /// again show a request for this permission. The user may still change the
  /// permission status in the settings.
  /// *Only supported on Android.*
  PermanentlyDenied,

  /// Mandatory but denied or permanently denied.
  Error,
  Disabled,
}
