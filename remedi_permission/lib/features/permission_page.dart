import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_permission/viewmodel/i_permission_viewmodel.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class PermissionPage<Permission> extends BasePage<IPermissionViewModel> {
  static const ROUTE_NAME = "/permission";

  PermissionPage({Key key, IPermissionViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  PermissionView body(
      BuildContext context, IPermissionViewModel viewModel, Widget child) {
    return PermissionView();
  }

  @override
  Future logScreenOpen(String screenName) async {}

  @override
  String get screenName => "permission";
}

class PermissionView extends BindingView<IPermissionViewModel> {
  @override
  Widget build(BuildContext context, IPermissionViewModel viewModel) {
    return FutureBuilder(
        future: viewModel.requestPermission(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.blueGrey.shade700),
              title: Text(
                "권한 요청",
                style: TextStyle(color: Colors.blueGrey.shade700),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: SafeArea(
              child: Container(),
            ),
          );
        });
  }
}
