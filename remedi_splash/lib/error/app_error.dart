class AppError extends Error {
  final String code;
  final String title;
  final String message;

  AppError({this.code, this.title, this.message});
}
