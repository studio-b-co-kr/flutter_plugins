import 'package:flutter/material.dart';
import 'package:remedi/architecture/architecture.dart';
import 'package:remedi/permission/app_permission.dart';
import 'package:remedi/permission/features/permission_single/permission_single_viewmodel.dart';

class PermissionSinglePage extends ViewModelBuilder<PermissionSingleViewModel> {
  static const routeName = "/permission_single";

  PermissionSinglePage({Key? key, required PermissionSingleViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, PermissionSingleViewModel read) {
    return const PermissionView();
  }
}

class PermissionView extends View<PermissionSingleViewModel> {
  const PermissionView({Key? key}) : super(key: key);

  @override
  Widget buildChild(BuildContext context, PermissionSingleViewModel watch,
      PermissionSingleViewModel read) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.blueGrey.shade700),
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              _Skip(
                  appPermission: read.appPermission,
                  onPressed: (appPermission) {})
            ],
          ),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Icon(read.appPermission.icon, size: 60),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(read.title,
                            style: TextStyle(
                                fontSize: 28, color: Colors.grey.shade700))),
                    Expanded(
                        flex: 2,
                        child: Center(
                            child: Text(
                          read.appPermission.description ?? "",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade900),
                        ))),
                    ErrorMessage(permission: read.appPermission),
                    _Button(
                      state: read.appPermission.state,
                      onPress: () {},
                    ),
                  ]),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}

class ErrorMessage extends StatelessWidget {
  final AppPermission permission;

  const ErrorMessage({Key? key, required this.permission}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (permission.shouldBeGranted) {
      return Container(
        margin: const EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        child: Text(
          "* ${permission.errorDescription}",
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
}

class _Skip extends StatelessWidget {
  final AppPermission appPermission;
  final void Function(AppPermission appPermission) onPressed;

  const _Skip({Key? key, required this.appPermission, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget ret = Container();
    if (appPermission.shouldBeGranted) {
      return ret;
    }

    String title = "Skip";
    if (appPermission.isGranted) {
      title = "Next";
    }

    return TextButton(
      onPressed: () {
        onPressed(appPermission);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(color: Colors.blue),
          ),
          const Icon(Icons.arrow_forward_ios_sharp,
              size: 16, color: Colors.blue)
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final AppPermissionState state;
  final void Function()? onPress;

  const _Button({Key? key, required this.state, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 16, left: 16, bottom: 32, top: 8),
        child: MaterialButton(
            color: _color(state),
            height: 40,
            minWidth: double.maxFinite,
            onPressed: onPress,
            child: _text(state)));
  }

  Color _color(AppPermissionState state) {
    if (state == AppPermissionState.permanentlyDenied) {
      return Colors.red;
    }
    return Colors.blue;
  }

  Widget _text(AppPermissionState state) {
    String text = "";
    Color color = Colors.white;
    switch (state) {
      case AppPermissionState.granted:
        text = "허용됨";
        color = Colors.grey.shade700;
        break;
      case AppPermissionState.unknown:
      case AppPermissionState.denied:
        text = "권한 요청하기";
        break;
      case AppPermissionState.permanentlyDenied:
        text = "세팅에서 권한 허용하기";
        break;
    }
    return Text(
      text,
      style: TextStyle(color: color),
    );
  }
}
