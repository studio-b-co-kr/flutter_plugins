import 'package:flutter/widgets.dart';

abstract class LoginUi {
  pop(BuildContext context, bool result) {
    return Navigator.of(context).pop(result);
  }
}
