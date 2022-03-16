part of 'mvvm.dart';

/// Data 와 State 를 묶은 Wrapper 클래스이다.
class StateData<S, D> {
  S? state;
  D? data;

  StateData({
    this.state,
    this.data,
  });
}

/// [IStateDataView] 는 여러 상태를 가지는 데이터를 표현 할 때 사용된다.
/// [StateData] 를 멤버로 가지며, [stateData] 의 상태와 데이터를 사용해 UI를 표현한다.
/// 주로 상태 변경이 있는 간단한 구조의 데이터를 보여줄 때 사용한다.
abstract class IStateDataView<S, D> extends StatelessWidget {
  final StateData<S, D> stateData;

  const IStateDataView({
    Key? key,
    required this.stateData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLog.log('build:state = ${stateData.state}',
        name: '${toString()}.$hashCode');
    AppLog.log('build:data = ${stateData.data}',
        name: '${toString()}.$hashCode');
    return buildWidget(context, stateData.state, stateData.data);
  }

  Widget buildWidget(BuildContext context, S? state, D? data);
}
