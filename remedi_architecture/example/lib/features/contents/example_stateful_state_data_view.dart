import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';
// ignore: must_be_immutable
class ExampleStatefulStateDataView extends StatefulStateDataView<int> {
  ExampleStatefulDataView({GlobalKey<StatefulDataViewState<int>>? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, data) {
    return Container();
  }
}

enum ViewState {
  loading,
  loaded,
}