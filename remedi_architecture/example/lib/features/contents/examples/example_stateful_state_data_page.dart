import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

import 'view_state.dart';

class ExampleStatefulStateDataPage
    extends ViewModelView<ExampleStatefulStateDataViewModel> {
  static const routeName = '/ExampleStatefulStateDataPage';

  ExampleStatefulStateDataPage(
      {Key? key, required ExampleStatefulStateDataViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  final GlobalKey<StatefulStateDataViewState<ViewState, int>> countKey =
      GlobalKey();

  @override
  Widget build(
    BuildContext context,
    ExampleStatefulStateDataViewModel watch,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeName.substring(1)),
      ),
      body: buildBody(context, watch),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 10,
        onPressed: watch.countStateData.state == ViewState.loading
            ? null
            : () {
                viewModel.increase();
              },
        child: Icon(
          Icons.add,
          color: Colors.grey.shade50,
        ),
      ),
    );
  }

  Widget buildBody(
    BuildContext context,
    ExampleStatefulStateDataViewModel watch,
  ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You have pushed the button this many times:'),
          const SizedBox(height: 8),
          CountView(key: countKey, stateData: watch.countStateData),
        ],
      ),
    );
  }
}

class ExampleStatefulStateDataViewModel extends ViewModel {
  static ExampleStatefulStateDataViewModel _instance =
      ExampleStatefulStateDataViewModel._();

  ExampleStatefulStateDataViewModel._();

  factory ExampleStatefulStateDataViewModel.singleton() {
    if (_instance.isDisposed) {
      _instance = ExampleStatefulStateDataViewModel._();
    }

    return _instance;
  }

  @override
  initialise() {}

  StateData<ViewState, int> countStateData =
      StateData(state: ViewState.loaded, data: 0);

  void increase() async {
    countStateData.state = ViewState.loading;
    updateUi();
    await Future.delayed(const Duration(seconds: 1));

    countStateData.data = (countStateData.data ?? 0) + 1;
    countStateData.state = ViewState.loaded;
    updateUi();
  }
}

// ignore: must_be_immutable

class CountView extends StatefulStateDataView<ViewState, int> {
  CountView({
    GlobalKey<StatefulStateDataViewState<ViewState, int>>? key,
    required StateData<ViewState, int> stateData,
  }) : super(key: key, stateData: stateData);

  @override
  Widget build(BuildContext context, ViewState? state, int? data) {
    return Text(_countString(state, data),
        style: Theme.of(context).textTheme.headline4);
  }

  String _countString(ViewState? state, int? data) {
    if (state == null || state == ViewState.loading) {
      return '...';
    }
    return '${data ?? 0}';
  }
}
