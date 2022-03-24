import 'package:flutter/widgets.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

abstract class ProviderWidget<P extends ChangeNotifier>
    extends StatelessWidget {
  const ProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLog.log('build', name: toString());
    return buildWidget(context, context.watch<P>(), context.read<P>());
  }

  Widget buildWidget(BuildContext context, P watch, P read);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}
