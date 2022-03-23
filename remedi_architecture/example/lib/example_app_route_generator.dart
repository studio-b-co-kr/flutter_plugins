import 'package:example/features/contents/contents_page.dart';
import 'package:example/features/contents/contents_view_model.dart';
import 'package:example/features/contents/examples/example_stateful_data_page.dart';
import 'package:example/features/contents/examples/example_stateful_state_data_page.dart';
import 'package:example/features/contents/examples/example_stateless_data_page.dart';
import 'package:example/features/contents/examples/example_stateless_state_data_page.dart';
import 'package:example/features/home/home_page.dart';
import 'package:example/features/home/home_view_model.dart';
import 'package:example/features/settings/settings_page.dart';
import 'package:example/features/settings/settings_view_model.dart';
import 'package:example/features/splash/splash_page.dart';
import 'package:example/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

///
class ExampleAppRouteGenerator extends RouteGenerator {
  ExampleAppRouteGenerator({ScreenLogger? screenLogger})
      : super(screenLogger: screenLogger);

  @override
  Route<dynamic>? generateRoute(
    RouteSettings settings,
  ) {
    Route<dynamic>? ret;
    switch (settings.name) {
      case SettingsPage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => SettingsPage(
            viewModelBuilder: () => SettingsViewModel.singleton(),
          ),
        );
        break;

      case ContentsPage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => ContentsPage(
            viewModelBuilder: () => ContentsViewModel.singleton(),
          ),
        );
        break;
      case SplashPage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => SplashPage(
            viewModelBuilder: () => SplashViewModel.singleton(),
          ),
        );
        break;
      case HomePage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => HomePage(
            viewModelBuilder: () => HomeViewModel.singleton(),
          ),
        );
        break;

      case ExampleStatelessDataPage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => ExampleStatelessDataPage(
            viewModelBuilder: () => ExampleStatelessDataViewModel.singleton(),
          ),
        );
        break;

      case ExampleStatelessStateDataPage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => ExampleStatelessStateDataPage(
            viewModelBuilder: () =>
                ExampleStatelessStateDataViewModel.singleton(),
          ),
        );
        break;

      case ExampleStatefulDataPage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => ExampleStatefulDataPage(
            viewModelBuilder: () => ExampleStatefulDataViewModel.singleton(),
          ),
        );
        break;

      case ExampleStatefulStateDataPage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => ExampleStatefulStateDataPage(
            viewModelBuilder: () =>
                ExampleStatefulStateDataViewModel.singleton(),
          ),
        );
        break;
    }

    return ret;
  }
}
