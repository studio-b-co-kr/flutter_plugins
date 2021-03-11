library remedi_auth;

import 'repository/i_storage.dart';

export 'auth_error.dart';
export 'auth_repository.dart';
export 'model/i_app_credential.dart';
export 'model/apple_credential.dart';
export 'model/kakao_credential.dart';
export 'repository/i_login_repository.dart';
export 'repository/i_storage.dart';

class AuthManager {
  static String _kakaoAppId;
  static bool _enableKakao = true;
  static bool _enableApple = true;
  static bool _enableEmailPassword = true;
  static IStorage _storage;

  static String get kakaoAppId => _kakaoAppId;

  static bool get enableKakao => _enableKakao;

  static bool get enableApple => _enableApple;

  static bool get enableEmailPassword => _enableEmailPassword;

  static IStorage get storage => _storage;

  static init({
    IStorage storage,
    bool enableKakao,
    String kakaoAppId,
    bool enableApple,
    bool enableEmailPassword,
  }) {
    _storage = storage;
    _kakaoAppId = kakaoAppId;
    _enableKakao = enableKakao ?? false;
    _enableApple = enableApple ?? false;
    _enableEmailPassword = enableEmailPassword ?? false;
  }
}
