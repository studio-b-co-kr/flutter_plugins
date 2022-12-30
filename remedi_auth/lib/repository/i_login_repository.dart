import 'package:remedi_auth/model/apple_credential.dart';
import 'package:remedi_auth/model/kakao_credential.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class ILoginRepository extends IRepository {
  /// loginWithApple must return null, AppCredential, AuthError
  Future<dynamic> loginWithApple(AppleCredential appleCredential);

  /// loginWithKakao must return null, AppCredential, AuthError
  Future<dynamic> loginWithKakao(KakaoCredential credential);
}
