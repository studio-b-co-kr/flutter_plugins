part of 'widgets.dart';

/// Data 와 State 를 묶은 Wrapper 클래스이다.
class StateData<S, D> {
  S? state;
  D? data;

  StateData({
    this.state,
    this.data,
  });
}
