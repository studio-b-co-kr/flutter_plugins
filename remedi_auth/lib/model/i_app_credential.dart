import 'package:remedi_auth/auth_error.dart';

abstract class ICredential {
  final String userId;
  final String accessToken;
  final String refreshToken;
  final AuthError error;

  ICredential({this.userId, this.accessToken, this.refreshToken, this.error});

  get isError => error != null;
}
