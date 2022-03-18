import 'dart:developer' as dev;

import 'package:example/main-common.dart';

main() {
  mainCommon(readyToRun: () async {
    /// TODO do something before run app
    /// ex. set config for product flavour, register firebase and etc.
  }, handleError: (error, stackTrace) async {
    /// TODO do something if there is an error not caught
    /// ex. exit app, report bug and etc
    dev.log('error = ${error.toString()}', name: 'ExampleApp-DEV');
    dev.log('stackTrace = ${stackTrace.toString()}', name: 'ExampleApp-DEV');
    // exit(1);
  });
}
