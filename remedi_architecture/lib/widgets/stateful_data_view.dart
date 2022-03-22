part of 'widgets.dart';

// ignore: must_be_immutable
abstract class StatefulDataView<T> extends StatefulWidget {
  T? data;

  StatefulDataView({GlobalKey<StatefulDataViewState<T>>? key, this.data})
      : super(key: key);

  @override
  StatefulDataViewState<T> createState() => StatefulDataViewState<T>();

  Widget build(BuildContext context, T? data);

  /// don't call this method direct.
  void initState() {}

  /// don't call this method direct.
  void dispose() {}

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}

class StatefulDataViewState<T> extends State<StatefulDataView<T>> {
  void updateData({T? data}) {
    AppLog.log('updateData($data)', name: toString());
    if (widget.data == data) {
      return;
    }
    setState(() {
      widget.data = data;
    });
  }

  @override
  void initState() {
    AppLog.log('initState()', name: toString());
    widget.initState();
    super.initState();
  }

  @override
  void dispose() {
    AppLog.log('dispose()', name: toString());
    widget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLog.log('build($context)', name: toString());
    return widget.build(context, widget.data);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}
