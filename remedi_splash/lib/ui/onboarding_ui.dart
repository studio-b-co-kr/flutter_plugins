import 'package:flutter/widgets.dart';

abstract class OnboardingUi {
  pop(BuildContext context, bool result) {
    return Navigator.of(context).pop(result);
  }
}
