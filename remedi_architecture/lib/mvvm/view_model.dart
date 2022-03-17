part of 'mvvm.dart';

/// [IViewModelView] 와 페이링 되는 View Model.
/// Create instance as singleton as can as possible.
/// If you do not use this class as a singleton,
/// there'll be some problem after hot-reload.
abstract class IViewModel with ChangeNotifier implements ReassembleHandler {
  bool _initialised = false;

  initialise();

  _init() {
    if (_initialised) {
      return;
    }

    AppLog.log('initialised', name: '${toString()}.$hashCode');
    _initialised = true;
    initialise();
  }

  linkAppModels(BuildContext context) {}

  @override
  void reassemble() {
    onHotReload();
  }

  void onHotReload() {
    AppLog.log('onHotReload', name: '${toString()}.$hashCode');
  }

  /// UI를 업데이트한다.
  updateUi() {
    AppLog.log('updateUi()', name: '${toString()}.$hashCode');
    notifyListeners();
  }

  final StreamController _streamController = StreamController();
  late final Stream _stream = _streamController.stream.asBroadcastStream();

  Stream get stream => _stream;

  /// action을 View에 알려준다.
  updateAction(action) {
    AppLog.log('updateAction() : action = $action',
        name: '${toString()}.$hashCode');
    _streamController.add(action);
  }

  @override
  void dispose() {
    _streamController.close();
    _initialised = false;
    super.dispose();
  }
}
