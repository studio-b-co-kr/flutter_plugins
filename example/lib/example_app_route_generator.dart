import 'package:example/app_models/settings_app_model.dart';
import 'package:example/features/contents/contents_page.dart';
import 'package:example/features/contents/contents_view_model.dart';
import 'package:example/features/home/home_page.dart';
import 'package:example/features/home/home_view_model.dart';
import 'package:example/features/settings/settings_page.dart';
import 'package:example/features/splash/splash_scene.dart';
import 'package:flutter/material.dart';
import 'package:remedi_flutter/remedi_flutter.dart';

import 'features/auth/auth_screen.dart';
import 'features/auth/phone/auth_phone.dart';

///
class ExampleAppRouteGenerator extends RouteGenerator {
  ExampleAppRouteGenerator({ScreenLogger? screenLogger})
      : super(screenLogger: screenLogger);

  @override
  Route<dynamic>? generateRoute(
    RouteSettings settings,
  ) {
    Route<dynamic>? ret;

    // ret = RemediSplash.generateRoute(
    //     settings: settings,
    //     background: const SplashBackground(),
    //     repository: const SplashRepository(),
    //     forceUpdatePage: ForceUpdatePage(
    //       viewModel: ForceUpdateViewModel(),
    //     ),
    //     introPage: IntroPage(viewModel: IntroViewModel()),
    //     permissionAllPage: PermissionListPage(
    //         viewModel: PermissionListViewModel(
    //             permissionList: RemediPermission.permissionList)),
    //     loginPage: LoginPage(viewModel: LoginViewModel()),
    //     onboardingPage: OnboardingPage(viewModel: OnboardingViewModel()));
    //
    // if (ret != null) {
    //   return ret;
    // }

    switch (settings.name) {
      case SplashScene.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => SplashScene(
            onFinished: () {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            },
            themeMode: context.watch<SettingsAppModel>().themeMode,
            darkTheme: context.watch<SettingsAppModel>().themeDark,
            theme: context.watch<SettingsAppModel>().themeLight,
          ),
        );
        break;
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

      case AuthScreen.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => const AuthScreen(),
        );

        break;
      case AuthPhoneScreen.routeName:
        ret = MaterialPageRoute(
          settings: settings,
          builder: (context) => const AuthPhoneScreen(),
        );
        break;
    }

    return ret;
  }
}
