import 'package:remedi/auth/repository/i_auth_repository.dart';

import 'remedi_auth.dart';

class AuthRepository extends IAuthRepository {
  static AuthRepository _instance = AuthRepository._();

  factory AuthRepository.instance() => _instance;

  AuthRepository._();

  static const String _KEY_USER_ID = "USER_ID";
  static const String _KEY_USER_CODE = "USER_CODE";
  static const String _KEY_ACCESS_TOKEN = "ACCESS_TOKEN";
  static const String _KEY_REFRESH_TOKEN = "REFRESH_TOKEN";

  Future writeAccessToken(String accessToken) async {
    if (accessToken.isEmpty) {
      return;
    }

    return await AuthManager.storage
        .write(key: _KEY_ACCESS_TOKEN, value: accessToken);
  }

  Future writeRefreshToken(String refreshToken) async {
    if (refreshToken.isEmpty) {
      return;
    }

    return await AuthManager.storage
        .write(key: _KEY_REFRESH_TOKEN, value: refreshToken);
  }

  Future writeUserId(dynamic userId) async {
    if (userId == null) {
      return;
    }

    if ("$userId".isEmpty) {
      return;
    }

    return await AuthManager.storage.write(key: _KEY_USER_ID, value: "$userId");
  }

  Future writeUserCode(String userCode) async {
    if ("$userId".isEmpty) {
      return;
    }

    return await AuthManager.storage
        .write(key: _KEY_USER_CODE, value: "$userCode");
  }

  Future<String?> get accessToken async =>
      await AuthManager.storage.read(key: _KEY_ACCESS_TOKEN);

  Future<String?> get refreshToken async =>
      await AuthManager.storage.read(key: _KEY_REFRESH_TOKEN);

  Future<String?> get userId async =>
      await AuthManager.storage.read(key: _KEY_USER_ID);

  Future<String?> get userCode async =>
      await AuthManager.storage.read(key: _KEY_USER_CODE);

  Future deleteAccessToken() async =>
      await AuthManager.storage.delete(key: _KEY_ACCESS_TOKEN);

  Future deleteRefreshToken() async =>
      await AuthManager.storage.delete(key: _KEY_REFRESH_TOKEN);

  Future deleteUserId() async =>
      await AuthManager.storage.delete(key: _KEY_USER_ID);

  Future deleteUserCode() async =>
      await AuthManager.storage.delete(key: _KEY_USER_CODE);
}
