import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

abstract class ViewModel with ChangeNotifier implements ReassembleHandler {
  init();

  linkAppProviders(BuildContext context) {}

  @override
  void reassemble() {
    onHotReload();
  }

  void onHotReload() {
    dev.log('onHotReload', name: '${toString()}.$hashCode');
  }

  updateUi() {
    dev.log('update()', name: '${toString()}.$hashCode');
    notifyListeners();
  }

  final StreamController _streamController = StreamController();
  late final Stream _stream = _streamController.stream.asBroadcastStream();

  Stream get stream => _stream;

  updateAction(action) {
    dev.log('update() : action = $action', name: '${toString()}.$hashCode');
    _streamController.add(action);
  }
}