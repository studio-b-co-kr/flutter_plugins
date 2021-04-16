import 'package:remedi_base/remedi_base.dart';

class KakaoCredential extends IDto {
  final String? accessToken;
  final int? id;

  KakaoCredential({this.accessToken, this.id})
      : assert(accessToken != null && accessToken.isNotEmpty),
        assert(id != null);

  @override
  Map<String, dynamic> get toJson =>
      {"sso_access_token": accessToken, "sso_id": id, "sso_provider": "kakao"};

  factory KakaoCredential.fromJson(Map<String, dynamic> map) {
    return KakaoCredential(accessToken: map['access_token'], id: map['id']);
  }
}
