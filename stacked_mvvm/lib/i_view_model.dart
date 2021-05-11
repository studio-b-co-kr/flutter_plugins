part of 'stacked_mvvm.dart';

abstract class IViewModel<S> extends BaseViewModel {
  late S state;

  @mustCallSuper
  IViewModel() {
    state = initState;
  }

  S get initState;

  /// use this method to move other screen or show popup
  update({S? state}) {
    if (state != null) {
      this.state = state;
    }

    try {
      notifyListeners();
    } catch (_) {}
  }

  init() async {}
}
