import 'package:flutter/widgets.dart';

abstract class PermissionUi {
  pop(BuildContext context, bool result) {
    return Navigator.of(context).pop(result);
  }
}
