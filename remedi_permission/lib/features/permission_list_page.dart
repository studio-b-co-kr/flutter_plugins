import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_permission/features/permission_list_item.dart';
import 'package:remedi_permission/features/permission_repository.dart';
import 'package:remedi_permission/features/permission_viewmodel.dart';
import 'package:remedi_permission/model/app_permission.dart';
import 'package:remedi_permission/viewmodel/i_permission_list_viewmodel.dart';
import 'package:remedi_permission/viewmodel/i_permission_viewmodel.dart';
import 'package:remedi_widgets/remedi_widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

// ignore: must_be_immutable
class PermissionListPage extends BasePage<IPermissionListViewModel> {
  static const ROUTE_NAME = "/permission_list";

  late final PermissionItemViewBuilder _permissionItemViewBuilder;
  final String? backTo;

  PermissionListPage(
      {Key? key, required IPermissionListViewModel viewModel, this.backTo})
      : super(key: key, viewModel: viewModel) {
    _permissionItemViewBuilder = PermissionItemViewBuilder(
        permissions: viewModel.repository.permissions,
        onRefresh: () {
          this.viewModel.refresh();
        });
  }

  @override
  PermissionListView body(
      BuildContext context, IPermissionListViewModel viewModel, Widget? child) {
    return PermissionListView(_permissionItemViewBuilder);
  }

  @override
  Future logScreenOpen(String screenName) async {}

  @override
  String get screenName => "permission_list";

  @override
  void onListen(BuildContext context, IPermissionListViewModel viewModel) {
    super.onListen(context, viewModel);
    switch (viewModel.state) {
      case PermissionListViewState.Init:
        break;
      case PermissionListViewState.Refresh:
        Future.forEach<IPermissionViewModel>(
            _permissionItemViewBuilder.listItems.map((e) => e.viewModel),
            (viewModel) async => await viewModel.refresh());
        break;
      case PermissionListViewState.Error:
        break;
      case PermissionListViewState.Skip:
        if (backTo == null) {
          Navigator.of(context).pop("skip");
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(backTo!, (route) => false);
        }
        break;
      case PermissionListViewState.AllGranted:
        if (backTo == null) {
          Navigator.of(context).pop('all_granted');
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(backTo!, (route) => false);
        }
        break;
    }
  }
}

class PermissionItemViewBuilder {
  final List<AppPermission> permissions;
  late List<PermissionListItemWidget> _listItems;
  final Function? onRefresh;

  List<PermissionListItemWidget> get listItems => _listItems;

  PermissionItemViewBuilder({required this.permissions, this.onRefresh}) {
    _listItems = _build(permissions);
  }

  List<PermissionListItemWidget> _build(List<AppPermission> permissions) {
    return List<PermissionListItemWidget>.of(permissions.where((element) {
      bool ret = true;
      if (element.platform == PermissionPlatform.ios) {
        ret = Platform.isIOS;
      } else if (element.platform == PermissionPlatform.android) {
        ret = Platform.isAndroid;
      }
      return ret;
    }).map<PermissionListItemWidget>((appPermission) =>
        PermissionListItemWidget(
          PermissionViewModel(repository: PermissionRepository(appPermission)),
          onPressed: onRefresh,
        )));
  }
}

class PermissionListView extends BindingView<IPermissionListViewModel> {
  final PermissionItemViewBuilder builder;

  PermissionListView(this.builder);

  @override
  Widget build(BuildContext context, IPermissionListViewModel viewModel) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(color: Colors.blueGrey.shade700),
              elevation: 0,
              actions: _buildActions(context, viewModel)),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: _buildList(context, viewModel),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }

  List<Widget> _buildList(
      BuildContext context, IPermissionListViewModel viewModel) {
    List<Widget> ret = [];

    ret.add(Container(
      child: Column(children: [
        SizedBox(height: 16),
        Icon(
          Icons.error_outline_sharp,
          color: Colors.amber.shade700,
          size: 60,
        ),
        SizedBox(height: 16),
        Text(
          "원활한 앱 사용을 위해서 아래의 권한이 필요합니다.",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {
            _requestAllPermissions(viewModel);
          },
          child: Text(
            "모두 허용하기",
            style: TextStyle(fontSize: 16),
          ),
        )
      ]),
    ));

    ret.addAll(_buildPermissionItem(viewModel));

    return ret;
  }

  _requestAllPermissions(IPermissionListViewModel viewModel) {
    viewModel.requestAll();
  }

  List<PermissionListItemWidget> _buildPermissionItem(
      IPermissionListViewModel viewModel) {
    return builder.listItems;
  }

  List<Widget> _buildActions(
      BuildContext context, IPermissionListViewModel viewModel) {
    List<Widget> ret = [];

    if (viewModel.hasError) {
      return [];
    }
    ret.add(Center(
      child: InkWell(
          onTap: () async {
            await viewModel.skipOrNext();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              FixedScaleText(
                  text: Text("건너뛰기",
                      style: TextStyle(color: Colors.blue, fontSize: 14))),
              Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.blue,
                size: 16,
              )
            ]),
          )),
    ));
    return ret;
  }
}
