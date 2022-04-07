import 'package:flutter/material.dart';
import 'package:remedi/remedi.dart';

import '../permission_single/permission_single_viewmodel.dart';

class PermissionListItem extends ViewModelBuilder<PermissionSingleViewModel> {
  PermissionListItem({
    Key? key,
    required PermissionSingleViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, PermissionSingleViewModel read) {
    return const PermissionItemView();
  }
}

class PermissionItemView extends ViewModelView<PermissionSingleViewModel> {
  const PermissionItemView({Key? key}) : super(key: key);

  @override
  Widget buildChild(BuildContext context, PermissionSingleViewModel watch,
      PermissionSingleViewModel read) {
    return const Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    );
  }
}
