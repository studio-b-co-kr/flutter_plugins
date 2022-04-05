import 'dart:developer' as dev;

import 'package:remedi/permission/app_permission.dart';
import 'package:remedi_permission/data/local_storage.dart';
import 'package:remedi_permission/remedi_permission.dart';
import 'package:remedi_permission/repository/i_permission_list_repository.dart';
import 'package:remedi_permission/viewmodel/i_permission_list_viewmodel.dart';

import '../../remedi.dart';
import '../permission.dart';
import 'permission_list_repository.dart';

class PermissionListViewModel extends ViewModel {
  final PermissionListRepository repository;

  PermissionListViewModel({required this.repository}) : super();

  PermissionListViewState get initState => PermissionListViewState.init;

  @override
  initialise() async {
    hasError = await checkError;
  }

  @override
  Future<bool> get checkError async {
    bool ret = false;

    await Future.forEach<AppPermission>(repository.permissions,
        (appPermission) async {
      await appPermission.loadStatus.then((status) => ret |=
          appPermission.mandatory &&
              !(status == PermissionStatus.granted ||
                  status == PermissionStatus.limited));
    });

    dev.log("checkError = $ret", name: "PermissionListViewModel");

    return ret;
  }

  @override
  Future requestAll() async {
    var ret = await repository.requestAll();

    updateUi();

    if (hasError = await checkError) {
      update(state: PermissionListViewState.error);
    }

    if (await PermissionManager.allGranted) {
      update(state: PermissionListViewState.allGranted);
    }
  }

  @override
  Future refresh() async {
    if (await repository.isAllGranted) {
      update(state: PermissionListViewState.allGranted);
    }
  }

  @override
  skipOrNext() async {
    hasError = await checkError;
    if (hasError) {
      update();
      return;
    }

    await LocalStorage.instance().skip();
    updateUi();
  }

  @override
  Future<bool> get canSkip async =>
      !(await checkError) && !(await repository.isAllGranted);

  @override
  Future<bool> get showNext async => false;

  Future<bool> get showRequestAll async => false;

  @override
  List<AppPermission> get permissions => repository.permissions;
}

enum PermissionListViewState {
  init,
  refresh,
  error,
  skip,
  allGranted,
}
