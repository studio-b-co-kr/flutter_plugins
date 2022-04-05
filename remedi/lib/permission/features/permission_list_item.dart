import 'package:flutter/material.dart';
import 'package:remedi/permission/features/permission_viewmodel.dart';
import 'package:remedi/remedi.dart';

class PermissionListItemWidget extends View<PermissionViewModel> {
  final Function? onPressed;

  const PermissionListItemWidget(PermissionViewModel viewModel,
      {Key? key, this.onPressed})
      : super(key: key);

  @override
  Widget buildChild(BuildContext context, PermissionViewModel watch,
      PermissionViewModel read) {
    return PermissionItemView(
      onPressed: onPressed,
    );
  }
}

class PermissionItemView extends View<PermissionViewModel> {
  final Function? onPressed;
  final Color? color;

  const PermissionItemView({Key? key, required this.onPressed, this.color})
      : super(key: key);

  @override
  Widget buildChild(BuildContext context, PermissionViewModel watch,
      PermissionViewModel read) {
    return Card(
      color: _background(read),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: read.state == PermissionViewState.granted ? 0 : 4,
      child: InkWell(
        onTap: read.isGranted
            ? null
            : () async {
                await read.requestPermission();
                if (onPressed != null) {
                  onPressed!();
                }
              },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                child: viewModel.icon(),
              ),
              Container(
                  child: Text(
                read.title,
                style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )),
            ]),
            const SizedBox(height: 16),
            Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(viewModel.description)),
            const SizedBox(height: 16),
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

  double _elevation(PermissionViewModel viewModel) {
    double ret = 4;
    return ret;
  }

  Color _background(PermissionViewModel viewModel) {
    Color ret = Colors.amber.shade50;
    switch (viewModel.state) {
      case PermissionViewState.Granted:
      case PermissionViewState.Limited:
        ret = color ?? Colors.grey.shade50;
        break;
      case PermissionViewState.Init:
      case PermissionViewState.Denied:
      case PermissionViewState.PermanentlyDenied:
        ret = color ?? Colors.grey.shade50;
        break;
      case PermissionViewState.Restricted:
      case PermissionViewState.Disabled:
        ret = color ?? Colors.grey.shade50;
        break;
      case PermissionViewState.Error:
        ret = Colors.red.shade50;
        break;
      case PermissionViewState.grantedAndExit:
        break;
    }
    return ret;
  }

  Widget _action(PermissionViewModel viewModel) {
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
}

class PermissionItemWidget extends StatelessWidget {
  final PermissionViewState state;
  const PermissionItemWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _background(state),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: state == PermissionViewState.granted ? 0 : 4,
      child: InkWell(
        onTap: state.loadIsGranted
            ? null
            : () async {
                await read.requestPermission();
                if (onPressed != null) {
                  onPressed!();
                }
              },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                child: viewModel.icon(),
              ),
              Container(
                  child: Text(
                read.title,
                style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )),
            ]),
            const SizedBox(height: 16),
            Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(viewModel.description)),
            const SizedBox(height: 16),
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

  double _elevation(PermissionViewState state) {
    double ret = 4;
    return ret;
  }

  Color _background(PermissionViewState state) {
    Color ret = Colors.amber.shade50;
    switch (state) {
      case PermissionViewState.granted:
      case PermissionViewState.limited:
        ret = color ?? Colors.grey.shade50;
        break;
      case PermissionViewState.init:
      case PermissionViewState.denied:
      case PermissionViewState.permanentlyDenied:
        ret = color ?? Colors.grey.shade50;
        break;
      case PermissionViewState.restricted:
      case PermissionViewState.disabled:
        ret = color ?? Colors.grey.shade50;
        break;
      case PermissionViewState.shouldGranted:
        ret = Colors.red.shade50;
        break;
      case PermissionViewState.grantedAndExit:
        break;
      default:
        break;
    }
    return ret;
  }

  Widget _action(PermissionViewState state) {
    IconData icon = Icons.check_circle_outline;
    Color iconColor = Colors.grey;
    switch (state) {
      case PermissionViewState.granted:
      case PermissionViewState.limited:
        iconColor = Colors.green;
        break;
      case PermissionViewState.init:
      case PermissionViewState.denied:
      case PermissionViewState.permanentlyDenied:
        icon = Icons.error_outline_sharp;
        iconColor = Colors.grey;
        break;
      case PermissionViewState.shouldGranted:
        icon = Icons.error_outline_sharp;
        iconColor = Colors.red;
        break;
      case PermissionViewState.restricted:
      case PermissionViewState.disabled:
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
}
