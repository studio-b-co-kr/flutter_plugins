import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:remedi_mvvm/mvvm/view_model.dart';

///
/// simple, static
abstract class View<T> extends StatelessWidget {
  final T? data;

  const View({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context, data);
  }

  Widget builder(BuildContext context, T? d);
}

class StateData<S, D> {
  S? state;
  D? data;

  StateData({
    this.state,
    this.data,
  });
}

///
/// simple, dynamic
abstract class StateView<S, D> extends StatelessWidget {
  final StateData<S, D> stateData;

  const StateView({
    Key? key,
    required this.stateData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context, stateData.state, stateData.data);
  }

  Widget builder(BuildContext context, S? s, D? d);
}

///
/// complicated, dynamic
abstract class ViewModelView<VM extends ViewModel> extends StatelessWidget {
  late final VM _vm;

  ViewModelView({Key? key, required VM vm}) : super(key: key) {
    _vm = vm;
  }

  Widget buildWidget(BuildContext context, VM vm);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VM>.value(
      value: _vm,
      child: Consumer<VM>(
        builder: (context, vm, _) {
          providers(context, vm);
          _onChanged(context, vm);
          return buildWidget(context, _vm);
        },
      ),
    );
  }

  @override
  StatelessElement createElement() {
    _vm.init();
    dev.log('createElement', name: 'createElement');
    return super.createElement();
  }

  providers(BuildContext context, VM vm) {
    vm.linkAppProviders(context);
  }

  _onChanged(BuildContext context, VM vm) {
    onChanged(context, vm, vm.action);
    vm.action = null;
  }

  onChanged<T>(BuildContext context, VM vm, T action) {
    dev.log(
        'onChanged\n'
        'vm = ${vm.toString()}.${vm.hashCode}\n'
        'action = $action',
        name: '${toString()}.$hashCode}');
  }
}
