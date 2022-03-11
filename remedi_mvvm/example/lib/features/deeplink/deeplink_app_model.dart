import 'dart:async';
import 'dart:developer' as dev;

import 'package:remedi_mvvm/remedi_mvvm.dart';

class DeeplinkAppModel extends ViewModel {
  StateData<CountState, int> stateData = StateData(state: CountState.waiting);

  int count = 0;

  StreamSubscription? subscription;

  @override
  init() {
    dev.log('init()', name: 'DeeplinkAppModel.$hashCode');
    subscription = Stream.periodic(const Duration(seconds: 5), (count) {
      return count;
    }).listen((event) {
      count++;
      notifyListeners();
    });
  }

  Future<void>? res;

  check() async {
    dev.log('res = ${res.hashCode}', name: 'DeeplinkAppModel');
  }

  @override
  void onHotReload() {
    super.onHotReload();
    subscription?.cancel();
  }
}

enum CountState {
  waiting,
  increased,
}
