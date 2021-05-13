import 'dart:developer' as dev;

import 'package:example/feature/home/home_repository.dart';
import 'package:example/feature/home/home_view_model.dart';
import 'package:example/viewmodel/i_home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import 'home_view.dart';

class HomePage extends IPage<IHomeViewModel> {
  static const ROUTE_NAME = "/";

  HomePage({Key? key, required HomeViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => HomePage(
        key: LabeledGlobalKey("HomePage"),
        viewModel: HomeViewModel(repository: HomeRepository()),
      ),
    );
  }

  @override
  String get screenName => "splash";

  @override
  Future logScreenOpen(String screenName) async {}

  @override
  IView<IHomeViewModel> body(
      BuildContext context, IHomeViewModel viewModel, Widget? child) {
    return HomeView(key: LabeledGlobalKey("HomeView"));
  }

  @override
  void onListen(BuildContext context, IHomeViewModel viewModel) {
    dev.log("count = ${viewModel.count}", name: "HomePage");
    super.onListen(context, viewModel);
  }
}
