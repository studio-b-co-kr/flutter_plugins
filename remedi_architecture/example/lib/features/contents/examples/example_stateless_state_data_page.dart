import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

import 'view_state.dart';

class ExampleStatelessStateDataPage
    extends ViewModelView<ExampleStatelessStateDataViewModel> {
  static const routeName = '/ExampleStatelessStateDataPage';

  const ExampleStatelessStateDataPage({
    Key? key,
    required ViewModelBuilder<ExampleStatelessStateDataViewModel>
        viewModelBuilder,
  }) : super(key: key, viewModelBuilder: viewModelBuilder);

  @override
  Widget build(
    BuildContext context,
    ExampleStatelessStateDataViewModel watch,
    ExampleStatelessStateDataViewModel read,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeName.substring(1)),
      ),
      body: buildBody(context, watch, read),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        disabledElevation: 0,
        elevation: 4,
        onPressed: watch.countStateData.state == ViewState.loading
            ? null
            : () {
                read.increase();
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
    ExampleStatelessStateDataViewModel watch,
    ExampleStatelessStateDataViewModel read,
  ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You have pushed the button this many times:'),
          const SizedBox(height: 8),
          CountView(stateData: watch.countStateData),
        ],
      ),
    );
  }
}

class ExampleStatelessStateDataViewModel extends ViewModel {
  static ExampleStatelessStateDataViewModel _instance =
      ExampleStatelessStateDataViewModel._();

  ExampleStatelessStateDataViewModel._();

  factory ExampleStatelessStateDataViewModel.singleton() {
    if (_instance.isDisposed) {
      _instance = ExampleStatelessStateDataViewModel._();
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

class CountView extends StatelessStateDataView<ViewState, int> {
  const CountView({Key? key, required StateData<ViewState, int> stateData})
      : super(key: key, stateData: stateData);

  @override
  Widget buildWidget(BuildContext context, ViewState? state, int? data) {
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
