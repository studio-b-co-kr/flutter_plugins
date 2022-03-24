import 'package:example/example_app.dart' as example_app;

void mainCommon({
  Future Function()? readyToRun,
  Future Function(dynamic error, StackTrace stackTrace)? handleError,
}) {
  /// do nothing here, use readyToRun in main-dev.dart or main-prod.dart
  example_app.run(
    readyToRun: readyToRun,
    handleError: handleError,
  );
}
