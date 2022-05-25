library remedi;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

export 'package:firebase_core/firebase_core.dart';
export 'package:provider/provider.dart';

export 'analytics/remedi_analytics.dart';
export 'app/app.dart';
export 'architecture/architecture.dart';
// export 'auth/auth.dart';
export 'engage/engage.dart';
export 'net/net.dart';
export 'scenario/scenario.dart';
// export 'permission/permission.dart';
export 'splash/splash.dart';
// export 'update/update.dart';
export 'widgets/widgets.dart';

part 'local_storage.dart';
part 'monitor/remedi_monitor.dart';

typedef VoidFutureCallback = Future<void> Function();
typedef ErrorHandler = Future<void> Function(
    dynamic error, StackTrace stackTrace);
