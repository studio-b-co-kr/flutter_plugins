part of 'mvvm.dart';

abstract class IViewModel with ChangeNotifier implements ReassembleHandler {
  bool initialised = false;

  initialise();

  _init() {
    if (initialised) {
      return;
    }

    dev.log('initialised', name: '${toString()}.$hashCode');
    initialised = true;
    initialise();
  }

  linkAppProviders(BuildContext context) {}

  @override
  void reassemble() {
    onHotReload();
  }

  void onHotReload() {
    dev.log('onHotReload', name: '${toString()}.$hashCode');
  }

  updateUi() {
    dev.log('update()', name: '${toString()}.$hashCode');
    notifyListeners();
  }

  final StreamController _streamController = StreamController();
  late final Stream _stream = _streamController.stream.asBroadcastStream();

  Stream get stream => _stream;

  updateAction(action) {
    dev.log('update() : action = $action', name: '${toString()}.$hashCode');
    _streamController.add(action);
  }

  @override
  void dispose() {
    _streamController.close();
    initialised = false;
    super.dispose();
  }
}
