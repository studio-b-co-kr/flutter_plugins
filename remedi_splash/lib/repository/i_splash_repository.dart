import 'package:remedi/remedi.dart';
import 'package:remedi_splash/feature/force_update/force_update_wrapper.dart';
import 'package:remedi_splash/feature/intro/intro_wrapper.dart';
import 'package:remedi_splash/feature/login/login_wrapper.dart';
import 'package:remedi_splash/feature/onboarding/onboarding_wrapper.dart';
import 'package:remedi_splash/feature/permission/permission_all_wrapper.dart';

abstract class ISplashRepository extends Repository {
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

  void goPermissionAll() {
    RemediRouter.pushReplacementNamed(PermissionAllWrapper.routeName);
  }

  Future<bool> needToLogin();

  void goLogin() {
    RemediRouter.pushReplacementNamed(LoginWrapper.routeName);
  }

  Future<bool> isCompletedOnboarding();

  void goOnboarding() {
    RemediRouter.pushReplacementNamed(OnboardingWrapper.routeName);
  }

  void readyToStart();
}
