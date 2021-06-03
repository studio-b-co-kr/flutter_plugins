part of 'stacked_mvvm.dart';

abstract class IViewModel<S> extends BaseViewModel {
  late S state;
  late StreamController<S> _streamController;
  late Stream<S> _stream;

  @mustCallSuper
  IViewModel() {
    state = initState;
    _streamController = StreamController<S>();
    _stream = _streamController.stream;
  }

  S get initState;

  /// use this method to move other screen or show popup
  update({required S state}) {
    _streamController.add(state);
    this.state = state;

    try {
      notifyListeners();
    } catch (_) {}
  }

  @mustCallSuper
  init() async {
    _streamController.add(initState);
  }

  get stream => _stream;

  @override
  void dispose() {
    // _streamController.close();
    super.dispose();
  }
}
