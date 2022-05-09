import 'dart:io';

import 'package:example/main-common.dart';
import 'package:remedi_flutter/remedi_flutter.dart';

main() {
  mainCommon(readyToRun: () async {
    /// TODO do something before run app
    /// ex. set config for product flavour, register firebase and etc.
  }, handleError: (error, stackTrace) async {
    /// TODO do something if there is an error not caught
    /// ex. exit app, report bug and etc
    AppLog.log('error = ${error.toString()}', name: 'ExampleApp-PROD');
    AppLog.log('stackTrace = ${stackTrace.toString()}',
        name: 'ExampleApp-PROD');
    exit(1);
  });
}
