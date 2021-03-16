import 'package:remedi_permission/repository/i_permission_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import '../remedi_permission.dart';

abstract class IPermissionViewModel
    extends BaseViewModel<PermissionViewState, IPermissionRepository> {
  final AppPermission permission;

  IPermissionViewModel(this.permission);

  requestPermission();
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
}
