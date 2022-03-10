import 'package:flutter/cupertino.dart';

abstract class ViewModel with ChangeNotifier {
  dynamic action;

  ViewModel();

  init();

  linkAppProviders(BuildContext context) {}
}
