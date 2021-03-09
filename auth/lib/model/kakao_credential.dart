class KakaoCredential {
  final String accessToken;
  final int id;

  KakaoCredential({this.accessToken, this.id})
      : assert(accessToken != null && accessToken.isNotEmpty),
        assert(id != null);
}
