part of 'permission.dart';

class PermissionAllPage extends ViewModelBuilder<PermissionAllViewModel> {
  PermissionAllPage({Key? key, required PermissionAllViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, PermissionAllViewModel read) {
    return Scaffold(
      body: Column(children: [
        const Expanded(
          child: Center(
            child: Text(
              'PERMISSION-ALL',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
            height: 48,
            minWidth: double.infinity,
            color: Colors.grey,
            onPressed: () {
              read.goNext();
            },
            child: Text(
              'GO NEXT',
              style: TextStyle(
                color: Colors.grey.shade50,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
