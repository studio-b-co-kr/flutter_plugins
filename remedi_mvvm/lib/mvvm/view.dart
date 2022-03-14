part of 'mvvm.dart';

///
/// simple, static
abstract class View<T> extends StatelessWidget {
  final T? data;

  const View({
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
