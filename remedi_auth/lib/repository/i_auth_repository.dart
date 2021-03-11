import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IAuthRepository extends BaseRepository {
  Future<String> get accessToken;

  Future writeAccessToken(String token);

  Future deleteAccessToken();

  Future<String> get refreshToken;

  Future writeRefreshToken(String token);

  Future deleteRefreshToken();

  Future<String> get userId;

  Future writeUserId(String userId);

  Future deleteUserId();

  Future _deleteAll() async {
    await Future.wait(
        [deleteUserId(), deleteAccessToken(), deleteRefreshToken()]);
  }

  Future<bool> get isLoggedIn async {
    String token = await accessToken;
    return token != null && token.isNotEmpty;
  }

  Future logout() async {
    await _deleteAll();
  }
}

