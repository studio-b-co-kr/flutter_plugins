part of 'widgets.dart';

// ignore: must_be_immutable
abstract class IStatefulStateDataView<S, D> extends StatefulWidget {
  StateData<S, D>? stateData;

  IStatefulStateDataView({
    required GlobalKey<StatefulStateDataViewState<S, D>> key,
    this.stateData,
  }) : super(key: key);

  @override
  StatefulStateDataViewState<S, D> createState() =>
      StatefulStateDataViewState<S, D>();

  Widget build(BuildContext context, S? state, D? data);

  /// don't call this method direct.
  void initState() {}

  /// don't call this method direct.
  void dispose() {}

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}

class StatefulStateDataViewState<S, D>
    extends State<IStatefulStateDataView<S, D>> {
  void updateState({S? state}) {
    setState(() {
      widget.stateData ??= StateData<S, D>();
      widget.stateData?.state = state;
      AppLog.log('updateState: state = $state', name: toString());
      AppLog.log(
          'updateState: widget.stateData?.state = ${widget.stateData?.state}',
          name: toString());
    });
  }

  void updateData({D? data}) {
    setState(() {
      widget.stateData ??= StateData<S, D>();
      widget.stateData?.data = data;
      AppLog.log('updateData: data = $data', name: toString());
      AppLog.log(
          'updateData: widget.stateData?.data = ${widget.stateData?.data}',
          name: toString());
    });
  }

  void updateStateData({StateData<S, D>? stateData}) {
    setState(() {
      widget.stateData = stateData;
      AppLog.log('updateStateData: stateData = $stateData', name: toString());
      AppLog.log('updateStateData: widget.stateData = ${widget.stateData}',
          name: toString());
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
    return widget.build(
        context, widget.stateData?.state, widget.stateData?.data);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}
