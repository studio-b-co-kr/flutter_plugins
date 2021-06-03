part of 'stacked_mvvm.dart';

abstract class IViewModel<S> extends BaseViewModel {
  late S state;
  late StreamController<S> _streamController;
  late Stream<S> _stream;

  @mustCallSuper
  IViewModel() {
    state = initState;
    _streamController = BehaviorSubject<S>();
    _stream = _streamController.stream;
  }

  S get initState;

  /// use this method to move other screen or show popup
  update({required S state}) {
    _add(state: initState);
    this.state = state;

    try {
      notifyListeners();
    } catch (_) {}
  }

  @mustCallSuper
  init() async {
    _add(state: initState);
  }

  get stream => _stream;

  void _add({required S state}) {
    if (_streamController.isClosed) {
      _streamController = BehaviorSubject<S>();
      _stream = _streamController.stream;
    }
    _streamController.add(state);
  }
}
