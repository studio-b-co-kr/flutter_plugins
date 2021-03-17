import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_permission/viewmodel/i_permission_viewmodel.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class PermissionPage<Permission> extends BasePage<IPermissionViewModel> {
  static const ROUTE_NAME = "/permission";

  final Permission permission;

  PermissionPage(this.permission, {Key key, IPermissionViewModel viewModel})
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
    return Scaffold();
  }
}
