part of 'force_update.dart';

class ForceUpdatePage extends ViewModelBuilder<ForceUpdateViewModel> {
  ForceUpdatePage({Key? key, required ForceUpdateViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, ForceUpdateViewModel read) {
    return const Scaffold(
      body: Center(
        child: Text(
          'FORCE\nUPDATE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
