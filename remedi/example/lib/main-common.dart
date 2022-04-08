import 'package:example/example_app.dart' as example_app;
import 'package:remedi/permission/app_permission.dart';
import 'package:remedi/permission/permission.dart';

void mainCommon({
  Future Function()? readyToRun,
  Future Function(dynamic error, StackTrace stackTrace)? handleError,
}) {
  /// do nothing here, use readyToRun in main-dev.dart or main-prod.dart
  example_app.run(
    readyToRun: () async {
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
      ]);

      if (readyToRun != null) {
        await readyToRun();
      }
    },
    handleError: handleError,
  );
}
