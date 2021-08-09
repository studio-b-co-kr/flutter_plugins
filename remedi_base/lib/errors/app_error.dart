class AppError extends Error {
  final String? code;
  final String? title;
  final String? message;
  final dynamic body;

  AppError({this.code, this.title, this.message, this.body});
}
