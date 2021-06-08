import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:remedi_permission/viewmodel/i_permission_viewmodel.dart';
import 'package:remedi_widgets/remedi_widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class PermissionListItemWidget extends IWidget<IPermissionViewModel> {
  final Function? onPressed;

  PermissionListItemWidget(IPermissionViewModel viewModel, {this.onPressed})
      : super(viewModel: viewModel);

  @override
  IView<IPermissionViewModel> body(
      BuildContext context, IPermissionViewModel viewModel, Widget? child) {
    return PermissionListItemView(onPressed);
  }

  @override
  void onListen(BuildContext context, IPermissionViewModel viewModel) {
    super.onListen(context, viewModel);
  }
}

class PermissionListItemView extends IView<IPermissionViewModel> {
  final Function? onPressed;

  PermissionListItemView(this.onPressed);

  @override
  Widget build(BuildContext context, IPermissionViewModel viewModel) {
    return Card(
      color: _background(viewModel),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: viewModel.state == PermissionViewState.Granted ? 0 : 4,
      child: InkWell(
        onTap: viewModel.isGranted
            ? null
            : () async {
                await viewModel.requestPermission();
                if (onPressed != null) {
                  onPressed!();
                }
              },
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                child: viewModel.icon(),
              ),
              Container(
                  child: FixedScaleText(
                      text: Text(
                viewModel.title,
                style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ))),
            ]),
            SizedBox(height: 16),
            Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(viewModel.description)),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _action(viewModel),
                  SizedBox(width: 8),
                  Expanded(
                      child:
                          FixedScaleText(text: Text(viewModel.statusMessage)))
                ],
              ),
            ),
            viewModel.isPermanentlyDenied
                ? Container(
                    margin: EdgeInsets.only(top: 16, left: 8),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FixedScaleText(
                              text: Text(
                            "앱 세팅에서 가서 권한을 부여해주세요",
                            style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )),
                          Icon(Icons.arrow_forward_ios_sharp,
                              color: Colors.blue.shade700, size: 16)
                        ]),
                  )
                : Container(),
          ]),
        ),
      ),
    );
  }

  double _elevation(IPermissionViewModel viewModel) {
    double ret = 4;
    return ret;
  }

  Color _background(IPermissionViewModel viewModel) {
    Color ret = Colors.amber.shade50;
    switch (viewModel.state) {
      case PermissionViewState.Granted:
      case PermissionViewState.Limited:
        ret = Colors.grey.shade50;
        break;
      case PermissionViewState.Init:
      case PermissionViewState.Denied:
      case PermissionViewState.PermanentlyDenied:
        ret = Colors.grey.shade50;
        break;
      case PermissionViewState.Restricted:
      case PermissionViewState.Disabled:
        ret = Colors.grey.shade50;
        break;
      case PermissionViewState.Error:
        ret = Colors.red.shade50;
        break;
      case PermissionViewState.grantedAndExit:
        break;
    }
    return ret;
  }

  Widget _action(IPermissionViewModel viewModel) {
    IconData icon = Icons.check_circle_outline;
    Color iconColor = Colors.grey;
    switch (viewModel.state) {
      case PermissionViewState.Granted:
      case PermissionViewState.Limited:
        iconColor = Colors.green;
        break;
      case PermissionViewState.Init:
      case PermissionViewState.Denied:
      case PermissionViewState.PermanentlyDenied:
        icon = Icons.error_outline_sharp;
        iconColor = Colors.grey;
        break;
      case PermissionViewState.Error:
        icon = Icons.error_outline_sharp;
        iconColor = Colors.red;
        break;
      case PermissionViewState.Restricted:
      case PermissionViewState.Disabled:
        break;
      case PermissionViewState.grantedAndExit:
        break;
    }
    return Icon(
      icon,
      size: 20,
      color: iconColor,
    );
  }
//
// String _resultMessage(IPermissionViewModel viewModel) {
//   String message = "";
//
//   return message;
// }
//
// Color _textColor(IPermissionViewModel viewModel) {
//   Color ret = Colors.blueGrey.shade700;
//
//   return ret;
// }
}
