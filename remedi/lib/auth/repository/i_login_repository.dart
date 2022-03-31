import 'package:remedi/auth/model/apple_credential.dart';
import 'package:remedi/auth/model/kakao_credential.dart';
import 'package:remedi/remedi.dart';

abstract class ILoginRepository extends Repository {
  /// loginWithApple must return null, AppCredential, AuthError
  Future<dynamic> loginWithApple(AppleCredential appleCredential);

  /// loginWithKakao must return null, AppCredential, AuthError
  Future<dynamic> loginWithKakao(KakaoCredential credential);
}
