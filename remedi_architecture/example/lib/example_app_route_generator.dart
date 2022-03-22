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
  ExampleAppRouteGenerator({Future Function(String screenName)? screenLogger})
      : super(screenLogger: screenLogger);

  @override
  Route<dynamic>? generateRoute(
    RouteSettings settings,
    RouteUri? uri,
  ) {
    Route<dynamic>? ret;
    if (uri?.name == SettingsPage.routeUri.name) {
      ret = MaterialPageRoute(
        settings: settings,
        builder: (context) => SettingsPage(
          viewModel: SettingsViewModel.singleton(),
        ),
      );
    } else if (uri?.name == ContentsPage.routeUri.name) {
      ret = MaterialPageRoute(
        settings: settings,
        builder: (context) => ContentsPage(
          viewModel: ContentsViewModel.singleton(),
        ),
      );
    } else if (uri?.name == SplashPage.routeUri.name) {
      ret = MaterialPageRoute(
        settings: settings,
        builder: (context) => SplashPage(
          viewModel: SplashViewModel.singleton(),
        ),
      );
    } else if (uri?.name == HomePage.routeUri.name) {
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
