import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

import 'view_state.dart';

class ExampleStatelessStateDataView
    extends StatelessStateDataView<ViewState, int> {
  const ExampleStatelessStateDataView(
      {Key? key, required StateData<ViewState, int> stateData})
      : super(key: key, stateData: stateData);

  @override
  Widget buildWidget(BuildContext context, ViewState? state, int? data) {
    return Container();
  }
}
