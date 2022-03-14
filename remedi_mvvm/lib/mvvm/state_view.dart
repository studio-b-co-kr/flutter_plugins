part of 'mvvm.dart';

class StateData<S, D> {
  S? state;
  D? data;

  StateData({
    this.state,
    this.data,
  });
}

///
/// simple, dynamic
abstract class StateView<S, D> extends StatelessWidget {
  final StateData<S, D> stateData;

  const StateView({
    Key? key,
    required this.stateData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dev.log('build:state = ${stateData.state}',
        name: '${toString()}.$hashCode');
    dev.log('build:data = ${stateData.data}', name: '${toString()}.$hashCode');
    return buildWidget(context, stateData.state, stateData.data);
  }

  Widget buildWidget(BuildContext context, S? state, D? data);
}
