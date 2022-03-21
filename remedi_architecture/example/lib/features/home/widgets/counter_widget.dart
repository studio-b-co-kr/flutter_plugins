import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

// ignore: must_be_immutable
class CountWidget extends IStatefulDataView<int> {
  CountWidget({required GlobalKey<StatefulDataViewState<int>> key, int? data})
      : super(key: key, data: data);

  @override
  Widget build(BuildContext context, int? data) {
    return Text(
      '$data',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 40),
    );
  }
}
