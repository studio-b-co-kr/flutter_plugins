import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_permission/features/permission_list_item.dart';
import 'package:remedi_permission/features/permission_repository.dart';
import 'package:remedi_permission/features/permission_viewmodel.dart';
import 'package:remedi_permission/viewmodel/i_permission_list_viewmodel.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class PermissionListPage extends BasePage<IPermissionListViewModel> {
  static const ROUTE_NAME = "/permission_list";

  PermissionListPage({Key key, IPermissionListViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  PermissionListView body(
      BuildContext context, IPermissionListViewModel viewModel, Widget child) {
    return PermissionListView();
  }

  @override
  Future logScreenOpen(String screenName) async {}

  @override
  String get screenName => "permission_list";
}

class PermissionListView extends BindingView<IPermissionListViewModel> {
  @override
  Widget build(BuildContext context, IPermissionListViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            "권한 요청",
            style: TextStyle(color: Colors.blueGrey.shade700),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.blueGrey.shade700),
          elevation: 0,
          actions: [
            Center(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text("SKIP", style: TextStyle(color: Colors.blue)),
            ))
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
          Icons.warning_amber_rounded,
          color: Colors.blueGrey.shade700,
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
            _requestAllPermissions();
          },
          child: Text(
            "모두 허용하기",
            style: TextStyle(fontSize: 18),
          ),
        )
      ]),
    ));

    ret.addAll(_buildPermissionItem(context, viewModel));

    ret.add(Container(
      height: 64,
    ));

    return ret;
  }

  _requestAllPermissions() {}

  List<PermissionListItemWidget> _buildPermissionItem(
      BuildContext context, IPermissionListViewModel viewModel) {
    return List<PermissionListItemWidget>.of(viewModel.permissions
        .map<PermissionListItemWidget>((appPermission) =>
            PermissionListItemWidget(PermissionViewModel(
                repository: PermissionRepository(appPermission)))));
  }
}
