import 'package:flutter/widgets.dart';

abstract class IntroUi {
  pop(BuildContext context, bool result) {
    return Navigator.of(context).pop(result);
  }
}
