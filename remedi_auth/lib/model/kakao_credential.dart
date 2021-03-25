import 'package:remedi_base/remedi_base.dart';

class KakaoCredential extends IDto {
  final String accessToken;
  final int id;

  KakaoCredential({this.accessToken, this.id})
      : assert(accessToken != null && accessToken.isNotEmpty),
        assert(id != null);

  @override
  Map<String, dynamic> toJson() {
    return {
      "access_token": accessToken,
      "id": id,
    };
  }

  factory KakaoCredential.fromJson({String accessToken, int id}) {
    return KakaoCredential(accessToken: accessToken, id: id);
  }
}
