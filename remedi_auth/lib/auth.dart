
export 'auth_error.dart';
export 'model/app_credential.dart';
export 'model/apple_credential.dart';
export 'model/kakao_credential.dart';
export 'repository/i_login_repository.dart';

class AuthConfig {
  static String _kakaoAppId;
  static bool _enableKakao = true;
  static bool _enableApple = true;
  static bool _enableEmailPassword = true;

  static String get kakaoAppId => _kakaoAppId;

  static bool get enableKakao => _enableKakao;

  static bool get enableApple => _enableApple;

  static bool get enableEmailPassword => _enableEmailPassword;

  static init({
    String kakaoAppId,
    bool enableKakao,
    bool enableApple,
    bool enableEmailPassword,
  }) {
    _kakaoAppId = kakaoAppId;
    _enableKakao = enableKakao ?? false;
    _enableApple = enableApple ?? false;
    _enableEmailPassword = enableEmailPassword ?? false;
  }
}
