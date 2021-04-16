import 'package:remedi_base/api_service/api_service.dart';

class AppleCredential extends IDto {
  final String? email;
  final String? identityToken;
  final String? userIdentifier;
  final String authorizationCode;

  AppleCredential(
      {this.email,
      this.identityToken,
      this.userIdentifier,
      required this.authorizationCode});

  @override
  Map<String, dynamic> get toJson => {
        "sso_token": identityToken,
        "sso_provider": "apple"
      };

  factory AppleCredential.fromJson(
      {String? email,
      String? identityToken,
      String? userIdentifier,
      required String authorizationCode}) {
    return AppleCredential(
        email: email,
        identityToken: identityToken,
        userIdentifier: userIdentifier,
        authorizationCode: authorizationCode);
  }
}
