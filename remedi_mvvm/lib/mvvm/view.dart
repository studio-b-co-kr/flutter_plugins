part of 'mvvm.dart';

///
/// simple, static
abstract class IDataView<T> extends StatelessWidget {
  final T? data;

  const IDataView({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dev.log('build:data = $data', name: '${toString()}.$hashCode');
    return buildWidget(context, data);
  }

  Widget buildWidget(BuildContext context, T? data);
}
