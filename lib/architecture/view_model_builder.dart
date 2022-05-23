part of 'architecture.dart';

/// [ViewModelBuilder] ViewModelBuilder 는 상태 변경이 많고 여러 가지 데이터 혹은,
/// 복잡한 데이터를 표시할 때 사용한다.
/// [ViewModel] 에 의해서 상태 및 데이터에 접근한다.
/// 주로 Page 를 만들 때 사용한다.
/// [VM]이 updateUi()를 하면 UI를 업데이트하고, updateAction(action) 시에는 UI 없데이트 없이
/// action 을 View에 전달한다.
/// AppModel

// ignore: must_be_immutable
abstract class ViewModelBuilder<VM extends ViewModel> extends StatefulWidget {
  late final VM _viewModel;

  ViewModelBuilder({
    Key? key,
    required final VM viewModel,
  }) : super(key: key) {
    _viewModel = viewModel;
  }

  @override
  _ViewModelBuilderState<VM> createState() => _ViewModelBuilderState<VM>();

  void initUi() {}

  void disposeUi() {}

  Widget build(BuildContext context, VM read);

  Widget _build(BuildContext context) {
    AppLog.log('_build($context)', name: toString());
    return build(context, context.read<VM>());
  }

  void onActionReceived(BuildContext context, dynamic action, VM read) {
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
    super.initState();
    _initialise();
    AppLog.log('initState.isMounted = $mounted', name: widget.toString());
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
    widget.initUi();
    subscription = viewModel.stream.listen((action) {
      if (mounted) {
        widget.onActionReceived(context, action, context.read());
      }
    });

    viewModel._init();
  }

  Stream get actionStream => viewModel.stream;

  VM get viewModel => widget._viewModel;

  @override
  void dispose() {
    widget.disposeUi();
    subscription?.cancel();
    super.dispose();
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}
