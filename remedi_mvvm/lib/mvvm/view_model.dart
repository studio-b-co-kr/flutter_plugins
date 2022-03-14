part of 'mvvm.dart';

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

  updateUi() {
    AppLog.log('updateUi()', name: '${toString()}.$hashCode');
    notifyListeners();
  }

  final StreamController _streamController = StreamController();
  late final Stream _stream = _streamController.stream.asBroadcastStream();

  Stream get stream => _stream;

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
