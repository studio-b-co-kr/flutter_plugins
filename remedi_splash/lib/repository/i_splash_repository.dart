import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class ISplashRepository extends BaseRepository {
  Future<dynamic> init();

  Future<bool> needToUpdate();

  Future<bool> donePermissionGrant();

  Future<bool> doneIntro();

  Future<bool> isLoggedIn();

  Future<bool> doneOnboarding();

  Future<dynamic> readyToService();
}
