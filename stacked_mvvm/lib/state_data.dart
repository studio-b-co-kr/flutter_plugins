part of 'stacked_mvvm.dart';

class StateData<D, S> {
  D? data;
  S state;

  StateData({this.data, required this.state});

  StateData<D, S> clone() {
    return StateData(data: this.data, state: this.state)
  }
}
