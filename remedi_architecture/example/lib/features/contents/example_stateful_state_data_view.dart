import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

import 'view_state.dart';

// ignore: must_be_immutable
class ExampleStatefulStateDataView
    extends StatefulStateDataView<ViewState, int> {
  ExampleStatefulStateDataView(
      {GlobalKey<StatefulStateDataViewState<ViewState, int>>? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, ViewState? state, int? data) {
    return Container();
  }
}
