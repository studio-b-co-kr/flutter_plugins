part of 'mvvm.dart';

///
/// complicated, dynamic
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VM>.value(
      value: viewModel,
      child: Consumer<VM>(
        builder: (context, vm, child) {
          _providers(context, vm);
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

  void _providers(BuildContext context, VM viewModel) {
    viewModel.linkAppProviders(context);
  }

  VM get viewModel => widget.viewModel;

  Stream get actionStream => widget.viewModel.stream;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}
