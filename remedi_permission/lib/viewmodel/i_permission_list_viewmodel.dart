import 'package:stacked_mvvm/stacked_mvvm.dart';

import '../remedi_permission.dart';

abstract class IPermissionListViewModel
    extends IViewModel<PermissionListViewState> {
  IPermissionListViewModel() : super();

  bool hasError = false;

  Future<dynamic> requestAll();

  Future<bool> get checkError;

  skipOrNext();

  Future<bool> get canSkip;

  Future<bool> get showNext;

  Future<bool> get showRequestAll;

  Future<dynamic> refresh();

  List<AppPermission> get permissions;
}

enum PermissionListViewState { Init, Refresh, Error, Skip, AllGranted }
