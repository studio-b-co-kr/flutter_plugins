import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_permission/viewmodel/i_permission_viewmodel.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class PermissionPage<Permission> extends BasePage<IPermissionViewModel> {
  static const ROUTE_NAME = "/permission";

  PermissionPage({Key? key, required IPermissionViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  PermissionView body(
      BuildContext context, IPermissionViewModel viewModel, Widget? child) {
    return PermissionView();
  }

  @override
  Future logScreenOpen(String screenName) async {}

  @override
  String get screenName => "permission";

  @override
  void onListen(BuildContext context, IPermissionViewModel viewModel) {
    super.onListen(context, viewModel);
    switch (viewModel.state) {
      case PermissionViewState.Init:
        break;
      case PermissionViewState.Granted:
        break;
      case PermissionViewState.Denied:
        break;
      case PermissionViewState.Restricted:
        break;
      case PermissionViewState.Limited:
        break;
      case PermissionViewState.PermanentlyDenied:
        break;
      case PermissionViewState.Error:
        break;
      case PermissionViewState.Disabled:
        break;
      case PermissionViewState.Exit:
        Navigator.of(context).pop();
        break;
    }
  }
}

class PermissionView extends BindingView<IPermissionViewModel> {
  @override
  Widget build(BuildContext context, IPermissionViewModel viewModel) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.blueGrey.shade700),
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [..._buildSkip(context, viewModel)],
          ),
          body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(flex: 1),
                  viewModel.icon(size: 60),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Text(viewModel.title,
                          style: TextStyle(fontSize: 28))),
                  Expanded(
                      flex: 2,
                      child: Center(child: Text(viewModel.description))),
                  _errorMessage(viewModel),
                  _buildButton(context, viewModel),
                ]),
          ),
        ),
        onWillPop: () async => false);
  }

  Color _buttonColor(IPermissionViewModel viewModel) {
    if (viewModel.repository.isPermanentlyDenied) {
      return Colors.red;
    }
    return Colors.blue;
  }

  Widget _buttonText(BuildContext context, IPermissionViewModel viewModel) {
    String text = "";
    Color color = Colors.white;
    if (viewModel.repository.isPermanentlyDenied) {
      text = "세팅에서 권한 허용하기";
    } else if (viewModel.repository.isGranted) {
      text = "허용됨";
      color = Colors.grey.shade700;
    } else
      text = "권한 요청하기";

    return Text(
      text,
      style: TextStyle(color: color),
    );
  }

  _onSkip(BuildContext context) async {
    Navigator.of(context).pop("skip");
  }

  Widget _errorMessage(IPermissionViewModel viewModel) {
    if (viewModel.repository.isError) {
      return Container(
        margin: EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        child: Text(
          "* ${viewModel.errorDescription}",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.red.shade700,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      );
    }

    return Container();
  }

  List<Widget> _buildSkip(
      BuildContext context, IPermissionViewModel viewModel) {
    List<Widget> ret = [];

    if (viewModel.repository.isError) {
      return ret;
    }

    String title = "Skip";
    if (viewModel.repository.isGranted) {
      title = "Next";
    }

    ret.add(Container(
        child: TextButton(
            onPressed: () async => await _onSkip(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(color: Colors.blue),
                ),
                Icon(Icons.arrow_forward_ios_sharp,
                    size: 16, color: Colors.blue)
              ],
            ))));

    return ret;
  }

  Widget _buildButton(BuildContext context, IPermissionViewModel viewModel) {
    return Container(
        margin: EdgeInsets.only(right: 16, left: 16, bottom: 32, top: 8),
        child: MaterialButton(
            color: _buttonColor(viewModel),
            height: 40,
            minWidth: double.maxFinite,
            onPressed: viewModel.repository.isGranted
                ? null
                : () async {
                    await viewModel.requestPermission();
                  },
            child: _buttonText(context, viewModel)));
  }
}
