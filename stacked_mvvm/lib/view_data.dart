part of 'stacked_mvvm.dart';

class ViewData<D, S> {
  D? data;
  S state;

  ViewData({this.data, required this.state});
}
