import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

// class CountWidget extends StatelessDataView<int> {
//   const CountWidget({Key? key, required int data})
//       : super(key: key, data: data);
//
//   @override
//   Widget buildWidget(BuildContext context, int? data) {
//     return Text(
//       '$data',
//       textAlign: TextAlign.center,
//       style: const TextStyle(fontSize: 40),
//     );
//   }
// }

// ignore: must_be_immutable
class CountWidget extends StatefulDataView<int> {
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
