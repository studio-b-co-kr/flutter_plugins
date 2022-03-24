import 'package:example/features/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/mvvm/view_model_widget.dart';

class CountWidget extends ProviderWidget<HomeViewModel> {
  const CountWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(
      BuildContext context, HomeViewModel watch, HomeViewModel read) {
    return Text(
      '${watch.count}',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 40),
    );
  }
}
