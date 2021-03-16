import 'package:flutter/material.dart';
import 'package:remedi_permission/viewmodel/i_permission_viewmodel.dart';
import 'package:remedi_widgets/remedi_widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class PermissionListItemWidget extends BaseWidget<IPermissionViewModel> {
  PermissionListItemWidget(IPermissionViewModel viewModel)
      : super(viewModel: viewModel);

  @override
  BindingView<IPermissionViewModel> body(
      BuildContext context, IPermissionViewModel viewModel, Widget child) {
    return PermissionListItemView();
  }

  @override
  void onListen(BuildContext context, IPermissionViewModel viewModel) {
    super.onListen(context, viewModel);
  }
}

class PermissionListItemView extends BindingView<IPermissionViewModel> {
  @override
  Widget build(BuildContext context, IPermissionViewModel viewModel) {
    return Card(
      color: background(viewModel),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: viewModel.state == PermissionViewState.Granted ? 0 : 4,
      child: InkWell(
        onTap: viewModel.repository.isGranted
            ? null
            : () {
                viewModel.requestPermission();
              },
        child: Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: viewModel.icon,
                ),
              ),
              Container(
                  child: FixedScaleText(
                      text: Text(
                viewModel.title,
                style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontWeight: FontWeight.bold),
              ))),
              Spacer(),
              action(viewModel),
            ]),
            SizedBox(height: 16),
            Container(child: Text(viewModel.description)),
            SizedBox(height: 8),
            Container(child: Text(viewModel.resultMessage)),
          ]),
        ),
      ),
    );
  }

  Color background(IPermissionViewModel viewModel) {
    Color ret = Colors.grey.shade100;
    switch (viewModel.state) {
      case PermissionViewState.Init:
        break;
      case PermissionViewState.Granted:
      case PermissionViewState.Limited:
        // ret = Colors.green.shade100;
        break;
      case PermissionViewState.Denied:
        ret = Colors.red.shade50;
        break;
      case PermissionViewState.PermanentlyDenied:
        ret = Colors.red.shade50;
        break;
      case PermissionViewState.Error:
        ret = Colors.red.shade100;
        break;
      case PermissionViewState.Restricted:
        break;
      case PermissionViewState.Disabled:
        break;
    }
    return ret;
  }

  Widget action(IPermissionViewModel viewModel) {
    IconData icon = Icons.check_circle_outline;
    Color iconColor = Colors.white;
    switch (viewModel.state) {
      case PermissionViewState.Init:
        break;
      case PermissionViewState.Granted:
      case PermissionViewState.Limited:
        iconColor = Colors.green;
        break;
      case PermissionViewState.Denied:
        iconColor = Colors.red.shade50;
        break;
      case PermissionViewState.PermanentlyDenied:
        iconColor = Colors.red.shade50;
        break;
      case PermissionViewState.Error:
        iconColor = Colors.red.shade100;
        break;
      case PermissionViewState.Restricted:
        break;
      case PermissionViewState.Disabled:
        break;
    }
    return Icon(
      icon,
      size: 36,
      color: iconColor,
    );
  }
}
