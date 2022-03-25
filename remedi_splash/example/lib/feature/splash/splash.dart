import 'package:example/feature/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:remedi/remedi.dart';
import 'package:remedi_splash/remedi_splash.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text(
          'SPLASH',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}

class SplashRepository extends ISplashRepository {
  @override
  Future appOpen() async {}

  @override
  void goIntro() {}

  @override
  void goLogin() {}

  @override
  void goOnboarding() {}

  @override
  void goPermission() {}

  @override
  void goUpdate() {}

  @override
  Future<bool> isCompletedIntro() async {
    return true;
  }

  @override
  Future<bool> isCompletedOnboarding() async {
    return true;
  }

  @override
  Future<bool> isCompletedPermissionGrant() async {
    return true;
  }

  @override
  Future<bool> needToLogin() async {
    return true;
  }

  @override
  Future<bool> needToUpdate() async {
    return false;
  }

  @override
  Future readyToService() async {
    AppLog.log('readyToService', name: toString());
    RemediRouter.pushReplacementNamed(HomePage.routeName);
  }
}
