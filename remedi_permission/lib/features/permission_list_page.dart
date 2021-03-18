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

  PermissionItemViewBuilder _permissionItemViewBuilder;

  PermissionListPage({Key key, IPermissionListViewModel viewModel})
      : super(key: key, viewModel: viewModel) {
    _permissionItemViewBuilder =
        PermissionItemViewBuilder(viewModel.repository.permissions);
  }

  @override
  PermissionListView body(
      BuildContext context, IPermissionListViewModel viewModel, Widget child) {
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
        Navigator.pop(context, "skip");
        break;
    }
  }
}

class PermissionItemViewBuilder {
  final List<AppPermission> permissions;
  List<PermissionListItemWidget> _listItems;

  List<PermissionListItemWidget> get listItems => _listItems;

  PermissionItemViewBuilder(this.permissions) {
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
        PermissionListItemWidget(PermissionViewModel(
            repository: PermissionRepository(appPermission)))));
  }
}

class PermissionListView extends BindingView<IPermissionListViewModel> {
  final PermissionItemViewBuilder builder;

  PermissionListView(this.builder);

  @override
  Widget build(BuildContext context, IPermissionListViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: FixedScaleText(
            text: Text(
              "권한 요청",
              style: TextStyle(color: Colors.blueGrey.shade700),
            ),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.blueGrey.shade700),
          elevation: 0,
          actions: [
            Center(
              child: InkWell(
                  onTap: () {
                    viewModel.skipOrNext();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: FixedScaleText(
                        text: Text("SKIP",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16))),
                  )),
            )
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: _buildList(context, viewModel),
          ),
        ),
      ),
    );
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

    ret.add(Container(
        margin: EdgeInsets.all(16),
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () {
            //_requestAllPermissions();
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    viewModel.skipOrNext();
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_sharp, size: 20)
              ]),
        )));

    return ret;
  }

  _requestAllPermissions(IPermissionListViewModel viewModel) {
    viewModel.requestAll();
  }

  List<PermissionListItemWidget> _buildPermissionItem(
      IPermissionListViewModel viewModel) {
    return builder.listItems;
  }
}
