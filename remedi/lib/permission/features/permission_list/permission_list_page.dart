part of 'permission_list.dart';

// ignore: must_be_immutable
class PermissionListPage extends ViewModelBuilder<PermissionListViewModel> {
  PermissionListPage({
    Key? key,
    required PermissionListViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  void initUi() {
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      AppLog.log(msg ?? "msg", name: 'LIFECYCLE');
    });
    super.initUi();
  }

  @override
  Widget build(BuildContext context, PermissionListViewModel read) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SkipButton(),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            child: Icon(
              Icons.error_outline,
              color: Colors.yellow.shade700,
              size: 60,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              '원활히 앱을 사용하기 위해 아래 권한들이 필요합니다.\n권한을 확인하고 허용해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          GrantAllButton(
            onTab: () {},
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: 0,
              ),
              child: const PermissionList(),
            ),
          )
        ]),
      ),
    );
  }
}
