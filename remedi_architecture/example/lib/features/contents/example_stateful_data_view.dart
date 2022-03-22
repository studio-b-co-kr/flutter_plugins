import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

// ignore: must_be_immutable
class ExampleStatefulDataView extends StatefulDataView<int> {
  ExampleStatefulDataView({GlobalKey<StatefulDataViewState<int>>? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, data) {
    return Container(
      child: Center(child: Text('${data ?? 0}')),
    );
  }
}
