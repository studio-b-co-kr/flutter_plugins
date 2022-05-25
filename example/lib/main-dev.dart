import 'dart:io';

import 'package:example/main-common.dart';
import 'package:remedi_flutter/app/app.dart';

/// dev product 의 Entry Point 이다.
/// product 에 따라서 달라야할 값들을 여기에서 정의한다.
/// [minaCommon] 을 호출해서 [RemediApp] 을 실행한다.
main() {
  mainCommon(readyToRun: () async {
    /// TODO do something before run app
    /// ex. set config for product flavour, register firebase and etc.
  }, handleError: (error, stackTrace) async {
    /// TODO do something if there is an error not caught
    /// ex. exit app, report bug and etc
    AppLog.log('error = ${error.toString()}', name: 'ExampleApp-DEV');
    AppLog.log('stackTrace = ${stackTrace.toString()}', name: 'ExampleApp-DEV');
    exit(1);
  });
}
