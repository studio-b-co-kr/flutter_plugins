part of 'widgets.dart';

// ignore: must_be_immutable
abstract class StatefulDataView<T> extends StatefulWidget {
  T? data;

  StatefulDataView(
      {required GlobalKey<StatefulDataViewState<T>> key, this.data})
      : super(key: key);

  @override
  StatefulDataViewState<T> createState() => StatefulDataViewState<T>();

  Widget build(BuildContext context, T? data);

  /// don't call this method direct.
  void initState() {}

  /// don't call this method direct.
  void dispose() {}
}

class StatefulDataViewState<T> extends State<StatefulDataView<T>> {
  void updateData({T? data}) {
    setState(() {
      widget.data = data;
    });
  }

  @override
  void initState() {
    widget.initState();
    super.initState();
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, widget.data);
  }
}
