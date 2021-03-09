import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IAuthRepository extends BaseRepository {
  Future<T> login<T, R>(R request);

  Future logout();

  Future<dynamic> loginWithKakao(String baseUrl);

  Future<dynamic> loginWithApple(String baseUrl);

  get accessToken;

  get refreshToken;
}
