class AuthError extends Error {
  final String? code;
  final String? title;
  final String? message;
  final dynamic error;

  StackTrace? get stackTrace {
    try {
      return error?.stackTrace;
    } catch (e) {
      return null;
    }
  }

  AuthError({this.title, this.code, this.message, this.error});
}
