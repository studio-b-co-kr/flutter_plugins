import 'package:example/example_app.dart' as example_app;
import 'package:remedi_flutter/permission/app_permission.dart';
import 'package:remedi_flutter/permission/permission.dart';
import 'package:remedi_flutter/remedi_flutter.dart';

void mainCommon({
  Future Function()? buildProductFlavour,
  Future Function(dynamic error, StackTrace stackTrace)? handleError,
}) {
  /// do nothing here, use readyToRun in main-dev.dart or main-prod.dart
  example_app.run(
    buildProductFlavour: buildProductFlavour,
    readyToRun: () async {
      Firebase.initializeApp();
      RemediPermission.init([
        AppPermission(Permission.location,
            title: '위치 접근 권한',
            description: '거리를 측정하기 위해 권한을 허융해 주세요.',
            warningDescription: '앱을 사용하기 위한 필수 권한입니다.',
            mandatory: true),
        AppPermission(
          Permission.camera,
          title: '카메라 접근 권한',
          description: 'description',
          warningDescription: 'Warning description',
        ),
        AppPermission(
          Permission.storage,
          title: '저장소 접근 권한',
          description: 'description',
          warningDescription: 'Warning description',
        ),
        AppPermission(
          Permission.contacts,
          title: '연락처 접근 권한',
          description: 'description',
          warningDescription: 'Warning description',
        ),
        AppPermission(
          Permission.calendar,
          title: '캘린더 접근 권한',
          description: 'description',
          warningDescription: 'Warning description',
        ),
        AppPermission(
          Permission.microphone,
          title: '마이크 접근 권한',
          description: 'description',
          warningDescription: 'Warning description',
        ),
      ]);
    },
    handleError: handleError,
  );
}
