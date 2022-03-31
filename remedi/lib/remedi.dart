library remedi;

export 'package:firebase_core/firebase_core.dart';
export 'package:provider/provider.dart';

export 'app/app.dart';
export 'architecture/architecture.dart';
export 'auth/auth.dart';
export 'engage/engage.dart';
export 'net/net.dart';
export 'permission/permission.dart';
export 'splash/splash.dart';
export 'update/update.dart';
export 'widgets/widgets.dart';

typedef VoidFutureCallback = Future<void> Function();
typedef ErrorHandler = Future<void> Function(
    dynamic error, StackTrace stackTrace);
