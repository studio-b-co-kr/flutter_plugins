import 'package:remedi_auth/model/i_app_credential.dart';
import 'package:remedi_auth/model/apple_credential.dart';
import 'package:remedi_auth/model/kakao_credential.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class ILoginRepository extends BaseRepository {
  /// loginWithApple must return null, AppCredential, AuthError
  Future<ICredential> loginWithApple(AppleCredential appleCredential);

  /// loginWithKakao must return null, AppCredential, AuthError
  Future<ICredential> loginWithKakao(KakaoCredential credential);
}
