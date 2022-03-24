part of 'architecture.dart';

/// [ViewModelBuilder] ViewModelView 는 상태 변경이 많고 여러 가지 데이터 혹은,
/// 복잡한 데이터를 표시할 때 사용한다.
/// [ViewModel] 에 의해서 상태 및 데이터에 접근한다.
/// 주로 Page를 만들 때 사용한다.
/// [VM]이 updateUi()를 하면 UI를 업데이트하고, updateAction(action) 시에는 UI 없데이트 없이
/// action 을 View에 전달한다.
/// AppModel

// ignore: must_be_immutable
abstract class ViewModelBuilder<VM extends ViewModel> extends StatefulWidget {
  late final VM _viewModel;

  ViewModelBuilder({
    Key? key,
    required VM viewModel,
  }) : super(key: key) {
    _viewModel = viewModel;
  }

  @override
  _ViewModelBuilderState<VM> createState() => _ViewModelBuilderState<VM>();

  Widget build(BuildContext context, VM read);

  Widget _build(BuildContext context) {
    AppLog.log('_build($context)', name: toString());
    return build(context, context.read<VM>());
  }

  void onActionReceived(BuildContext context, dynamic action) {
    AppLog.log('onActionReceived: action = $action', name: toString());
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}

class _ViewModelBuilderState<VM extends ViewModel>
    extends State<ViewModelBuilder<VM>> implements ReassembleHandler {
  @override
  void initState() {
    _initialise();
    AppLog.log('initState.isMounted = $mounted', name: widget.toString());
    super.initState();
  }

  @override
  void reassemble() {
    onHotRefresh();
    super.reassemble();
  }

  void onHotRefresh() {
    AppLog.log('onHotRefresh', name: widget.toString());
  }

  @override
  Widget build(BuildContext context) {
    AppLog.log('build', name: widget.toString());

    // if (viewModel.isDisposed) {
    //   throw Exception('You cannot reuse a disposed ViewModel again.\n\n'
    //       'If you want to use the ViewModel as a singleton instance,\n'
    //       'please make a constructor of the ViewModel as below.\n\n'
    //       'class ContentsViewModel extends IViewModel {\n'
    //       ' static ContentsViewModel _instance = ContentsViewModel._();\n\n'
    //       ' ContentsViewModel._();\n\n'
    //       ' factory ContentsViewModel.singleton() {\n'
    //       '   if (_instance.isDisposed) {\n'
    //       '     _instance = ContentsViewModel._();\n'
    //       '   }\n\n'
    //       '   return _instance;\n'
    //       ' }\n\n'
    //       ' @override\n'
    //       ' initialise() {}\n'
    //       '}\n');
    // }

    return ChangeNotifierProvider<VM>(
      create: (context) {
        AppLog.log('create $viewModel', name: widget.toString());
        return viewModel;
      },
      builder: (context, child) {
        AppLog.log('build $widget', name: widget.toString());
        return widget._build(context);
      },
    );
  }

  StreamSubscription? subscription;

  _initialise() {
    subscription = viewModel.stream.listen((action) {
      if (mounted) {
        widget.onActionReceived(context, action);
      }
    });
    viewModel._init();
  }

  Stream get actionStream => viewModel.stream;

  VM get viewModel => widget._viewModel;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}
