import 'package:flutter/material.dart';
import 'package:remedi/remedi.dart';

import 'permission_list_view_model.dart';

// ignore: must_be_immutable
class PermissionListPage extends ViewModelBuilder<PermissionListViewModel> {
  static const routeName = "/permission_list";

  PermissionListPage({
    Key? key,
    required PermissionListViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, PermissionListViewModel read) {
    return const Scaffold();
  }
}
