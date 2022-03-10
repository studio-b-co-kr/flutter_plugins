import 'dart:developer' as dev;

import 'package:remedi_mvvm/remedi_mvvm.dart';

class DeeplinkAppModel extends ViewModel {
  @override
  init() {
    dev.log('init()', name: 'DeeplinkAppModel.$hashCode');
  }
}
