import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class ExampleStatefulDataPage
    extends ViewModelBuilder<ExampleStatefulDataViewModel> {
  static const routeName = '/ExampleStatefulDataPage';

  ExampleStatefulDataPage(
      {Key? key, required ExampleStatefulDataViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  final GlobalKey<StatefulDataViewState<int>> countKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeName.substring(1)),
      ),
      body: buildBody(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 10,
        onPressed: () {
          viewModel.increase();
        },
        child: Icon(
          Icons.add,
          color: Colors.grey.shade50,
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You have pushed the button this many times:'),
          const SizedBox(height: 8),
          CountView(
            key: countKey,
            data: context.watch<ExampleStatefulDataViewModel>().count,
          ),
        ],
      ),
    );
  }

  @override
  void onActionReceived(BuildContext context, action) {
    super.onActionReceived(context, action);
    if (action == 'increase') {
      // countKey.currentState?.updateData(data: viewModel.count);
    }
  }
}

class ExampleStatefulDataViewModel extends ViewModel {
  static ExampleStatefulDataViewModel _instance =
      ExampleStatefulDataViewModel._();

  ExampleStatefulDataViewModel._();

  factory ExampleStatefulDataViewModel.singleton() {
    if (_instance.isDisposed) {
      _instance = ExampleStatefulDataViewModel._();
    }

    return _instance;
  }

  @override
  initialise() {}

  int count = 0;

  void increase() {
    count++;
    updateUi();
    // updateAction('increase');
  }
}

// ignore: must_be_immutable
class CountView extends StatefulDataView<int> {
  CountView({GlobalKey<StatefulDataViewState<int>>? key, int? data})
      : super(key: key, data: data);

  @override
  Widget build(BuildContext context, int? data) {
    return Text('${data ?? 0}', style: Theme.of(context).textTheme.headline4);
  }
}
