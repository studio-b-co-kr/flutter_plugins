part of 'permission.dart';

class PermissionAllPage extends ViewModelBuilder<PermissionAllViewModel> {
  PermissionAllPage({Key? key, required PermissionAllViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, PermissionAllViewModel read) {
    return const Scaffold(
      body: Center(
        child: Text(
          'PERMISSION\nALL',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
