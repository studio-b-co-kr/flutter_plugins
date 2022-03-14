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
    dev.log('build:data = $data', name: '${toString()}.$hashCode');
    return buildWidget(context, data);
  }

  Widget buildWidget(BuildContext context, T? data);
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
    dev.log('build:state = ${stateData.state}',
        name: '${toString()}.$hashCode');
    dev.log('build:data = ${stateData.data}', name: '${toString()}.$hashCode');
    return buildWidget(context, stateData.state, stateData.data);
  }

  Widget buildWidget(BuildContext context, S? state, D? data);
}

///
/// complicated, dynamic
abstract class ViewModelView<VM extends ViewModel> extends StatefulWidget {
  final VM viewModel;

  const ViewModelView({Key? key, required this.viewModel}) : super(key: key);

  @override
  _ViewModelViewState<VM> createState() => _ViewModelViewState<VM>();

  Widget build(BuildContext context, VM viewModel);

  void onActionChanged(BuildContext context, VM vm, dynamic action) {
    dev.log('onActionChanged: action = $action',
        name: '${toString()}.$hashCode');
  }
}

class _ViewModelViewState<VM extends ViewModel>
    extends State<ViewModelView<VM>> {
  @override
  void initState() {
    _initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VM>.value(
      value: viewModel,
      child: Consumer<VM>(
        builder: (context, vm, child) {
          _providers(context, vm);
          return widget.build(context, vm);
        },
      ),
    );
  }

  _initialise() {
    widget.viewModel.stream.listen((event) {
      if (mounted) {
        widget.onActionChanged(context, viewModel, event);
      }
    });
    widget.viewModel.init();
  }

  void _providers(BuildContext context, VM viewModel) {
    viewModel.linkAppProviders(context);
  }

  VM get viewModel => widget.viewModel;

  Stream get actionStream => widget.viewModel.stream;
}
