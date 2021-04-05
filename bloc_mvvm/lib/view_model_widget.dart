import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:bloc_mvvm/view_model.dart';
import 'package:flutter/cupertino.dart';

abstract class ViewModelWidget<V extends ViewModel> extends StatelessWidget
    implements BlocObserver {
  final V? viewModel;

  ViewModelWidget({Key? key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<V>(
        stream:viewModel.stream1,
        builder: (context, snapshot) => buildWidget(context));
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    dev.log("onChange", name: "ViewModelWidget");
  }

  @override
  void onClose(BlocBase bloc) {
    dev.log("onClose", name: "ViewModelWidget");
  }

  @override
  void onCreate(BlocBase bloc) {
    dev.log("onCreate", name: "ViewModelWidget");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    dev.log("onError", name: "ViewModelWidget");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    dev.log("onEvent", name: "ViewModelWidget");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    dev.log("onTransition", name: "ViewModelWidget");
  }

  Widget buildWidget(BuildContext context);
}
