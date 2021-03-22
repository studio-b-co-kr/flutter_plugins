import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class ISplashRepository extends BaseRepository {
  Future<dynamic> init();

  Future<bool> needToUpdate();

  Future<bool> isCompletedPermissionGrant();

  Future<bool> isCompletedIntro();

  Future<bool> isLoggedIn();

  Future<bool> isCompletedOnboarding();

  Future<dynamic> readyToService();
}
