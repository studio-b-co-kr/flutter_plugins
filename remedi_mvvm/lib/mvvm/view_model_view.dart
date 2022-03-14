part of 'mvvm.dart';

/// [IViewModelView] ViewModelView 는 상태 변경이 많고 여러 가지 데이터 혹은,
/// 복잡한 데이터를 표시할 때 사용한다.
/// [ViewModel] 에 의해서 상태 및 데이터에 접근한다.
/// 주로 Page를 만들 때 사용한다.
/// [VM]이 updateUi()를 하면 UI를 업데이트하고, updateAction(action) 시에는 UI 없데이트 없이
/// action 을 View에 전달한다.
/// AppModel
abstract class IViewModelView<VM extends IViewModel> extends StatefulWidget {
  final VM viewModel;

  const IViewModelView({Key? key, required this.viewModel}) : super(key: key);

  @override
  _ViewModelViewState<VM> createState() => _ViewModelViewState<VM>();

  Widget build(BuildContext context, VM viewModel);

  void onActionChanged(BuildContext context, VM vm, dynamic action) {
    dev.log('onActionChanged: action = $action',
        name: '${toString()}.$hashCode');
  }
}

class _ViewModelViewState<VM extends IViewModel>
    extends State<IViewModelView<VM>> {
  @override
  void initState() {
    _initialise();
    dev.log('initState.isMounted = $mounted', name: '${toString()}.$hashCode');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    dev.log('didChangeDependencies', name: '${toString()}.$hashCode');
    dev.log('didChangeDependencies.isMounted = $mounted',
        name: '${toString()}.$hashCode');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant IViewModelView<VM> oldWidget) {
    dev.log('didUpdateWidget', name: '${toString()}.$hashCode');
    dev.log('didUpdateWidget.isMounted = $mounted',
        name: '${toString()}.$hashCode');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      _appModels(context, viewModel);
    }
    dev.log('build', name: '${toString()}.$hashCode');
    return ChangeNotifierProvider<VM>.value(
      value: viewModel,
      child: Consumer<VM>(
        builder: (context, vm, child) {
          return widget.build(context, vm);
        },
      ),
    );
  }

  StreamSubscription? subscription;

  _initialise() {
    subscription = viewModel.stream.listen((event) {
      if (mounted) {
        widget.onActionChanged(context, viewModel, event);
      }
    });
    viewModel._init();
  }

  void _appModels(BuildContext context, VM viewModel) {
    viewModel.linkAppModels(context);
  }

  VM get viewModel => widget.viewModel;

  Stream get actionStream => widget.viewModel.stream;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}
