import 'package:example/viewmodel/i_home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class CountView extends BindingView<IHomeViewModel> {
  CountView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, IHomeViewModel viewModel) {
    return Text('${viewModel.count}',
        key: const Key('counterState'),
        style: Theme.of(context).textTheme.headline4);
  }
}
