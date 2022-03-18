import 'package:example/example_app.dart';

void mainCommon({
  Future Function()? readyToRun,
  Future Function(dynamic error, StackTrace stackTrace)? handleError,
}) {
  app.run(
    readyToRun: readyToRun,
    handleError: handleError,
  );
}
