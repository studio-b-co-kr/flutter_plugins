part of 'widgets.dart';

/// [StatelessDataView] 는 데이터와 바인딩되는 가장 심플한 형태의 Widget 이다.
/// 상태는 데이터 [T] 가 null 이거나 null 이 아닌 경우만 처리한다.
/// 주로 상태 변경이 없는 간략한 데이터를 보여줄 때 사용한다.
abstract class IStatelessDataView<T> extends StatelessWidget {
  final T? data;

  const IStatelessDataView({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLog.log('build:data = $data', name: toString());
    return buildWidget(context, data);
  }

  Widget buildWidget(BuildContext context, T? data);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}