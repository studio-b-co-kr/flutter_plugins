class AuthError {
  final String code;
  final String title;
  final String message;
  final Error error;

  StackTrace get stackTrace => error?.stackTrace;

  AuthError({this.title, this.code, this.message, this.error});
}
