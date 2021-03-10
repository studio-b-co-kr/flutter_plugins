class AppleCredential {
  final String email;
  final String identityToken;
  final String userIdentifier;
  final String authorizationCode;

  AppleCredential(
      {this.email,
      this.identityToken,
      this.userIdentifier,
      this.authorizationCode});
}
