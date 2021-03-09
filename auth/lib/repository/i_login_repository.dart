import 'package:remedi_flutter_plugin_auth/model/apple_credential.dart';
import 'package:remedi_flutter_plugin_auth/model/kakao_credential.dart';
import 'package:remedi_flutter_plugin_auth/repository/i_auth_repository.dart';

abstract class ILoginRepository extends IAuthRepository {
  /// loginWithApple must return null, AppCredential, AuthError
  Future<dynamic> loginWithApple(AppleCredential appleCredential);

  /// loginWithKakao must return null, AppCredential, AuthError
  Future<dynamic> loginWithKakao(KakaoCredential credential);
}
