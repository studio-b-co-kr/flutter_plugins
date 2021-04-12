import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:extension/extension.dart';

class ViewModel<VM, T extends ViewState> extends Cubit<T> {
  late final StreamController<VM> _streamController1;

  ViewModel(T initialState) : super(initialState) {
    _streamController1 = StreamController();
  }

  Stream<VM> get stream1 => _streamController1.stream;

  @override
  void onChange(Change<T> change) {
    super.onChange(change);
    dev.log("onChange", name: "ViewModel");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    dev.log("onError", name: "ViewModel");
  }
}

abstract class ViewState extends Enum<int> {
  const ViewState(int value) : super(value);
}
