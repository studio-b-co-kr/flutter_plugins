import 'package:bloc_mvvm/bloc_mvvm.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        viewModel: MyHomeViewModel(MyHomeViewState.INIT),
      ),
    );
  }
}



class MyHomePage extends ViewModelWidget<MyHomeViewModel> {
  MyHomePage({Key? key, MyHomeViewModel? viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text("${viewModel?.i ?? ""}", style: TextStyle(fontSize: 30))),
      floatingActionButton: MaterialButton(
        color: Colors.blue,
        onPressed: () {
          viewModel?.increase();
        },
        child: Text("+", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class MyHomeViewModel extends ViewModel<MyHomeViewState> {
  MyHomeViewModel(MyHomeViewState initialState) : super(initialState);
  int i = 0;

  increase() {
    i += 1;
    emit(MyHomeViewState.INCREASE);
  }
}

class MyHomeViewState extends ViewState {
  const MyHomeViewState(int value) : super(value);
  static const MyHomeViewState INIT = MyHomeViewState(0);
  static const MyHomeViewState INCREASE = MyHomeViewState(0);
}
