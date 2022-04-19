import 'package:remedi_flutter/remedi_flutter.dart';

import '../../app_permission.dart';
import '../../permission.dart';

class PermissionSingleViewModel extends ViewModel {
  final AppPermission appPermission;

  PermissionSingleViewModel({required this.appPermission}) : super();

  @override
  initialise() async {
    appPermission.loadStatus;
    updateUi();
  }

  Future<bool> goToSettings() async {
    return await openAppSettings();
  }

  Future<void> request() async {
    await appPermission.request();
    updateUi();
  }

  String get description => appPermission.description ?? "";

  String get errorDescription => appPermission.warningDescription ?? "";

  String get title => appPermission.title ?? "";

  Future refresh() async {
    appPermission.loadStatus;
    updateUi();
  }
}
