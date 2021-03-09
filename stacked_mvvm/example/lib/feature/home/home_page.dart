import 'package:example/feature/home/home_view_model.dart';
import 'package:example/viewmodel/i_home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import 'home_view.dart';

class HomePage extends BasePage<IHomeViewModel> {
  static const ROUTE_NAME = "/";

  HomePage({Key key, HomeViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => HomePage(
        key: LabeledGlobalKey("HomePage"),
        viewModel: HomeViewModel(),
      ),
    );
  }

  @override
  String get screenName => "splash";

  @override
  Future logScreenOpen(String screenName) async {}

  @override
  BindingView<IHomeViewModel> body(
      BuildContext context, IHomeViewModel viewModel, Widget child) {
    return HomeView(key: LabeledGlobalKey("HomeView"));
  }
}
