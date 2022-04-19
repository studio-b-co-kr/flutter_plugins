import 'package:remedi_flutter/remedi_flutter.dart';
import 'package:remedi_flutter/splash/feature/force_update/force_update_wrapper.dart';
import 'package:remedi_flutter/splash/feature/intro/intro_wrapper.dart';
import 'package:remedi_flutter/splash/feature/login/login_wrapper.dart';
import 'package:remedi_flutter/splash/feature/onboarding/onboarding_wrapper.dart';
import 'package:remedi_flutter/splash/feature/permission/permission_all_wrapper.dart';

abstract class ISplashRepository extends Repository {
  const ISplashRepository() : super();

  Future<dynamic> appOpen();

  Future<bool> needToUpdate();

  void goUpdate() {
    RemediRouter.pushReplacementNamed(ForceUpdateWrapper.routeName);
  }

  Future<bool> isCompletedIntro();

  void goIntro() {
    RemediRouter.pushReplacementNamed(IntroWrapper.routeName);
  }

  Future<bool> isCompletedPermissionGrant();

  void goPermissionAll() async {
    await RemediRouter.pushNamed(PermissionAllWrapper.routeName);
    RemediRouter.pushReplacementNamed(
      RemediSplash.routeName,
      arguments: RemediSplash.afterPermission,
    );
  }

  Future<bool> needToLogin();

  void goLogin() {
    RemediRouter.pushReplacementNamed(LoginWrapper.routeName);
  }

  Future<bool> isCompletedOnboarding();

  void goOnboarding() {
    RemediRouter.pushReplacementNamed(OnboardingWrapper.routeName);
  }

  void readyToService();
}
