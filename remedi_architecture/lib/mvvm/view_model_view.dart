part of 'mvvm.dart';

/// [ViewModelView] ViewModelView 는 상태 변경이 많고 여러 가지 데이터 혹은,
/// 복잡한 데이터를 표시할 때 사용한다.
/// [ViewModel] 에 의해서 상태 및 데이터에 접근한다.
/// 주로 Page를 만들 때 사용한다.
/// [VM]이 updateUi()를 하면 UI를 업데이트하고, updateAction(action) 시에는 UI 없데이트 없이
/// action 을 View에 전달한다.
/// AppModel
typedef ViewModelBuilder<VM> = VM Function();

abstract class ViewModelView<VM extends ViewModel> extends StatefulWidget {
  final VM viewModel;

  const ViewModelView({Key? key, required this.viewModel}) : super(key: key);

  @override
  _ViewModelViewState<VM> createState() => _ViewModelViewState<VM>();

  Widget build(BuildContext context, VM watch);

  Widget _build(BuildContext context) {
    AppLog.log('_build($context)', name: toString());
    return build(context, context.watch<VM>());
  }

  void onActionChanged(BuildContext context, dynamic action) {
    AppLog.log('onActionChanged: action = $action', name: toString());
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString(minLevel: minLevel)}.$hashCode';
  }
}

class _ViewModelViewState<VM extends ViewModel>
    extends State<ViewModelView<VM>> {
  @override
  void initState() {
    _initialise();
    AppLog.log('initState.isMounted = $mounted', name: toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLog.log('build', name: toString());
    if (mounted) {
      _appModels(context, viewModel);
    }

    if (viewModel.isDisposed) {
      throw Exception('You cannot reuse a disposed ViewModel again.\n\n'
          'If you want to use the ViewModel as a singleton instance,\n'
          'please make a constructor of the ViewModel as below.\n\n'
          'class ContentsViewModel extends IViewModel {\n'
          ' static ContentsViewModel _instance = ContentsViewModel._();\n\n'
          ' ContentsViewModel._();\n\n'
          ' factory ContentsViewModel.singleton() {\n'
          '   if (_instance.isDisposed) {\n'
          '     _instance = ContentsViewModel._();\n'
          '   }\n\n'
          '   return _instance;\n'
          ' }\n\n'
          ' @override\n'
          ' initialise() {}\n'
          '}\n');
    }

    return ChangeNotifierProvider<VM>(
      create: (context) {
        AppLog.log('ChangeNotifierProvider.create()', name: toString());
        return viewModel;
      },

      builder: (context, child) {
        AppLog.log('ChangeNotifierProvider.builder()', name: toString());
        return widget._build(context);
      },
      // child: widget._build(context),
      // child: Consumer<VM>(
      //   builder: (context, vm, child) {
      //     AppLog.log('Consumer.builder()', name: toString());
      //     return widget.build(context, vm);
      //   },
      // ),
    );
  }

  StreamSubscription? subscription;

  _initialise() {
    subscription = viewModel.stream.listen((action) {
      if (mounted) {
        AppLog.log('onActionChanged:action = $action',
            name: viewModel.toString());
        widget.onActionChanged(context, action);
      }
    });
    viewModel._init();
  }

  void _appModels(BuildContext context, VM viewModel) {
    viewModel.linkAppModels(context);
  }

  Stream get actionStream => viewModel.stream;

  VM get viewModel => widget.viewModel;

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
