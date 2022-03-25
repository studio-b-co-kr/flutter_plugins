part of 'architecture.dart';

/// [ViewModelBuilder] 와 페이링 되는 View Model.
/// Create instance as singleton as can as possible.
/// If you do not use this class as a singleton,
/// there'll be some problem after hot-reload.
abstract class ViewModel with ChangeNotifier implements ReassembleHandler {
  bool _initialised = false;

  initialise();

  _init() {
    if (_initialised) {
      return;
    }

    AppLog.log('initialised', name: toString());
    _initialised = true;
    initialise();
  }

  @override
  void reassemble() {
    onHotRefresh();
  }

  void onHotRefresh() {
    AppLog.log('onHotRefresh', name: toString());
  }

  /// UI를 업데이트한다.
  updateUi() {
    AppLog.log('updateUi()', name: toString());
    notifyListeners();
  }

  final StreamController _streamController = StreamController();
  late final Stream _stream = _streamController.stream.asBroadcastStream();

  Stream get stream => _stream;

  /// action을 View에 알려준다.
  updateAction(action) {
    AppLog.log('updateAction() : action = $action', name: toString());
    _streamController.add(action);
  }

  bool _disposed = false;

  @override
  void dispose() {
    _streamController.close();
    _initialised = false;
    super.dispose();
    _disposed = true;
  }

  bool get isDisposed => _disposed;

  @override
  String toString() {
    return '${super.toString()}.$hashCode';
  }
}
