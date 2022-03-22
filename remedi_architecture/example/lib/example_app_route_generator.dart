import 'package:example/features/contents/contents_page.dart';
import 'package:example/features/contents/contents_view_model.dart';
import 'package:example/features/home/home_page.dart';
import 'package:example/features/home/home_view_model.dart';
import 'package:example/features/settings/settings_page.dart';
import 'package:example/features/settings/settings_view_model.dart';
import 'package:example/features/splash/splash_page.dart';
import 'package:example/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

///
class ExampleAppRouteGenerator extends IRouteGenerator {
  ExampleAppRouteGenerator({ScreenLogger? screenLogger})
      : super(screenLogger: screenLogger);

  @override
  Route<dynamic>? generateRoute(
    RouteSettings settings,
    String? routeName,
    Map<String, dynamic>? data,
  ) {
    Route<dynamic>? ret;
    if (routeName == SettingsPage.routeUri.name) {
      ret = MaterialPageRoute(
        settings: settings,
        builder: (context) => SettingsPage(
          viewModel: SettingsViewModel.singleton(),
        ),
      );
    } else if (routeName == ContentsPage.routeUri.name) {
      ret = MaterialPageRoute(
        settings: settings,
        builder: (context) => ContentsPage(
          viewModel: ContentsViewModel.singleton(),
        ),
      );
    } else if (routeName == SplashPage.routeUri.name) {
      ret = MaterialPageRoute(
        settings: settings,
        builder: (context) => SplashPage(
          viewModel: SplashViewModel.singleton(),
        ),
      );
    } else if (routeName == HomePage.routeUri.name) {
      ret = MaterialPageRoute(
        settings: settings,
        builder: (context) => HomePage(
          viewModel: HomeViewModel.singleton(),
        ),
      );
    }

    return ret;
  }
}
