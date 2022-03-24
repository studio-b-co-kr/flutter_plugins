import 'package:remedi/architecture/architecture.dart';

abstract class ISplashRepository extends Repository {
  Future<dynamic> init();

  Future<bool> needToUpdate();

  Future<bool> isCompletedPermissionGrant();

  Future<dynamic> isCompletedIntro();

  Future<dynamic> isCompletedOnboarding();

  Future<dynamic> readyToService();

  Future<dynamic> afterPermission();
}
