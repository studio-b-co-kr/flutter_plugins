import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

abstract class ViewModel with ChangeNotifier implements ReassembleHandler {
  dynamic action;

  ViewModel();

  init();

  linkAppProviders(BuildContext context) {}

  @override
  void reassemble() {
    onHotReload();
  }

  void onHotReload() {
    dev.log('onHotReload', name: '${toString()}.$hashCode');
  }
}
