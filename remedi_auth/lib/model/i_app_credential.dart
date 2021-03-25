import 'package:remedi_auth/auth_error.dart';
import 'package:remedi_base/remedi_base.dart';

abstract class ICredential extends IDto {
  final String userId;
  final String accessToken;
  final String? refreshToken;
  final AuthError? error;

  ICredential(
      {required this.userId,
      required this.accessToken,
      this.refreshToken,
      this.error});

  get isError => error != null;
}
