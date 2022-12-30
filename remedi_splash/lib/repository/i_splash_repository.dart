import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class ISplashRepository extends IRepository {
  Future<dynamic> init();

  Future<bool> needToUpdate();

  Future<bool> isCompletedPermissionGrant();

  Future<dynamic> isCompletedIntro();

  Future<bool> isLoggedIn();

  Future<dynamic> isCompletedOnboarding();

  Future<dynamic> readyToService();

  Future<dynamic> afterPermission();
}
