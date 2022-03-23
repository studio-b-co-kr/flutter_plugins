import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class ExampleStatelessDataPage
    extends ViewModelView<ExampleStatelessDataViewModel> {
  static const routeName = '/ExampleStatelessDataPage';

  const ExampleStatelessDataPage({
    Key? key,
    required ViewModelBuilder<ExampleStatelessDataViewModel> viewModelBuilder,
  }) : super(key: key, viewModelBuilder: viewModelBuilder);

  @override
  Widget build(
    BuildContext context,
    ExampleStatelessDataViewModel watch,
    ExampleStatelessDataViewModel read,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeName.substring(1)),
      ),
      body: buildBody(context, watch, read),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 10,
        onPressed: () {
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
    ExampleStatelessDataViewModel watch,
    ExampleStatelessDataViewModel read,
  ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You have pushed the button this many times:'),
          const SizedBox(height: 8),
          CountView(data: watch.count),
        ],
      ),
    );
  }
}

class ExampleStatelessDataViewModel extends ViewModel {
  static ExampleStatelessDataViewModel _instance =
      ExampleStatelessDataViewModel._();

  ExampleStatelessDataViewModel._();

  factory ExampleStatelessDataViewModel.singleton() {
    if (_instance.isDisposed) {
      _instance = ExampleStatelessDataViewModel._();
    }

    return _instance;
  }

  @override
  initialise() {}

  int count = 0;

  void increase() {
    count++;
    updateUi();
  }
}

class CountView extends StatelessDataView<int> {
  const CountView({Key? key, int? data}) : super(key: key, data: data);

  @override
  Widget buildWidget(BuildContext context, int? data) {
    return Text('${data ?? 0}', style: Theme.of(context).textTheme.headline4);
  }
}
