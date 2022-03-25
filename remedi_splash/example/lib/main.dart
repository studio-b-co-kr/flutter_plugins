import 'package:example/feature/force_update/force_update.dart';
import 'package:example/feature/home/home_page.dart';
import 'package:example/feature/intro/intro.dart';
import 'package:example/feature/login/login.dart';
import 'package:example/feature/onboarding/onboarding.dart';
import 'package:example/feature/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:remedi/remedi.dart';
import 'package:remedi_splash/remedi_splash.dart';

import 'feature/permission/permission.dart';

void main() {
  RemediApp(
      enableLog: true,
      appModels: [],
      appBuilder: (BuildContext context) {
        return MaterialApp(
          navigatorKey: RemediRouter.navigatorKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: RemediSplash.routeName,
          onGenerateRoute: (settings) {
            Route? ret = RemediSplash.generateRoute(
              settings: settings,
              background: const SplashBackground(),
              repository: SplashRepository(),
              forceUpdatePage:
                  ForceUpdatePage(viewModel: ForceUpdateViewModel()),
              introPage: IntroPage(viewModel: IntroViewModel()),
              permissionAllPage:
                  PermissionAllPage(viewModel: PermissionAllViewModel()),
              loginPage: LoginPage(viewModel: LoginViewModel()),
              onboardingPage: OnboardingPage(viewModel: OnboardingViewModel()),
            );
            if (ret != null) {
              return ret;
            }
            switch (settings.name) {
              case HomePage.routeName:
                ret = MaterialPageRoute(
                    settings: settings,
                    builder: (context) {
                      return const HomePage();
                    });
                break;
            }

            return ret;
          },
        );
      }).run();
}
