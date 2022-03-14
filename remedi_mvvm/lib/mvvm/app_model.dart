part of 'mvvm.dart';

abstract class AppModel with ChangeNotifier implements ReassembleHandler {
  bool? withInit;

  AppModel({this.withInit = false}) {
    dev.log('withInit = $withInit', name: '${toString()}.$hashCode');
    if (withInit ?? false) {
      _init();
    }
  }

  bool initialised = false;

  initialise();

  _init() {
    if (initialised) {
      return;
    }

    dev.log('initialised', name: '${toString()}.$hashCode');
    initialise();
    initialised = true;
  }

  @override
  void reassemble() {
    onHotReload();
  }

  void onHotReload() {
    dev.log('onHotReload', name: '${toString()}.$hashCode');
  }

  @override
  void dispose() {
    initialised = false;
    super.dispose();
  }
}
