import 'dart:developer' as dev;

import 'package:remedi_mvvm/remedi_mvvm.dart';

class DeeplinkAppModel extends ViewModel {
  bool loopCondition = false;

  @override
  init() {
    loopCondition = true;
    dev.log('init()', name: 'DeeplinkAppModel.$hashCode');
    check();
  }

  check() async {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 10));
      dev.log('[${DateTime.now()}] notifyListeners',
          name: 'DeeplinkAppModel.$hashCode');
      notifyListeners();
      return loopCondition;
    });
  }

  @override
  void onHotReload() {
    super.onHotReload();
    loopCondition = false;
  }
}
