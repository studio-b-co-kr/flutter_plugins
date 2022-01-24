import 'package:remedi_auth/auth_error.dart';

abstract class ICredential {
  final String userId;
  final String userCode;
  final String userRole;
  final String accessToken;
  final String? refreshToken;
  final AuthError? error;

  ICredential({
    required this.userId,
    required this.userCode,
    required this.userRole,
    required this.accessToken,
    this.refreshToken,
    this.error,
  });

  get isError => error != null;
}
