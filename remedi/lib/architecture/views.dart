part of 'architecture.dart';

/// Wrapper class for providing ViewModel and AppModel
abstract class View<P extends ChangeNotifier> extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLog.log('build', name: toString());
    return buildChild(context, context.watch<P>(), context.read<P>());
  }

  Widget buildChild(BuildContext context, P watch, P read);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}

typedef BuilderView<P> = Widget Function(BuildContext context, P watch, P read);

/// Wrapper class for providing ViewModel and AppModel
class ViewBuilder<P extends ChangeNotifier> extends StatelessWidget {
  final BuilderView<P> builder;

  const ViewBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLog.log('build', name: toString());
    return builder(context, context.watch<P>(), context.read<P>());
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}
