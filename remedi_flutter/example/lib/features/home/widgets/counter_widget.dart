import 'package:example/features/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_flutter/remedi_flutter.dart';

class CountWidget extends ViewModelView<HomeViewModel> {
  const CountWidget({Key? key}) : super(key: key);

  @override
  Widget buildChild(
      BuildContext context, HomeViewModel watch, HomeViewModel read) {
    return Text(
      '${watch.count}',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 40),
    );
  }
}
