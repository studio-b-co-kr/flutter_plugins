import 'dart:developer' as dev;

import 'package:example/app.dart';

void main() {
  app.run(
    readyToRun: () async {
      /// TODO do something before run app
      /// ex. register firebase and etc.
    },
    handleError: (error, stackTrace) async {
      /// TODO do something if there is an error not caught
      /// ex. exit app, report bug and etc
      dev.log('error = ${error.toString()}', name: '');
      dev.log('stackTrace = ${stackTrace.toString()}', name: '');
      // exit(1);
    },
  );
}
