import 'package:example/features/contents/contents_page.dart';
import 'package:example/features/contents/contents_view_model.dart';
import 'package:example/features/force_update/force_update.dart';
import 'package:example/features/home/home_page.dart';
import 'package:example/features/home/home_view_model.dart';
import 'package:example/features/intro/intro.dart';
import 'package:example/features/login/login.dart';
import 'package:example/features/onboarding/onboarding.dart';
import 'package:example/features/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:remedi/permission/features/permission_list/permission_list_page.dart';
import 'package:remedi/permission/features/permission_list/permission_list_view_model.dart';
import 'package:remedi/permission/permission.dart';
import 'package:remedi/remedi.dart';

import 'features/splash/splash.dart';

///
class ExampleAppRouteGenerator extends RouteGenerator {
  ExampleAppRouteGenerator({ScreenLogger? screenLogger})
      : super(screenLogger: screenLogger);

  @override
  Route<dynamic>? generateRoute(
    RouteSettings settings,
  ) {
    Route<dynamic>? ret;

    ret = RemediSplash.generateRoute(
        settings: settings,
        background: const SplashBackground(),
        repository: const SplashRepository(),
        forceUpdatePage: ForceUpdatePage(
          viewModel: ForceUpdateViewModel(),
        ),
        introPage: IntroPage(viewModel: IntroViewModel()),
        permissionAllPage: PermissionListPage(
            viewModel: PermissionListViewModel(
                permissionList: RemediPermission.permissionList)),
        loginPage: LoginPage(viewModel: LoginViewModel()),
        onboardingPage: OnboardingPage(viewModel: OnboardingViewModel()));

    if (ret != null) {
      return ret;
    }

    switch (settings.name) {
      case SettingsPage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => const SettingsPage(),
        );
        break;

      case ContentsPage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => ContentsPage(
            viewModel: ContentsViewModel(),
          ),
        );
        break;
      case HomePage.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => HomePage(
            viewModel: HomeViewModel(),
          ),
        );
        break;
    }

    return ret;
  }
}
