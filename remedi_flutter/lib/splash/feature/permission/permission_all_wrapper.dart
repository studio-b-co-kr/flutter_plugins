import 'package:flutter/cupertino.dart';

class PermissionAllWrapper extends StatelessWidget {
  static const routeName = '/permission_all';
  final Widget permissionAllPage;

  const PermissionAllWrapper({Key? key, required this.permissionAllPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return permissionAllPage;
  }
}
