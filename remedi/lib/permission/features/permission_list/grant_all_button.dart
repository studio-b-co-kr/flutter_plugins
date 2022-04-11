part of 'permission_list.dart';

class GrantAllButton extends ViewModelView<PermissionListViewModel> {
  const GrantAllButton({Key? key}) : super(key: key);

  @override
  Widget buildChild(BuildContext context, PermissionListViewModel watch,
      PermissionListViewModel read) {
    return InkWell(
      onTap: () {
        if (read.shouldRecheck) {
          read.loadStateAll();
        } else if (read.canSkipAll) {
          RemediRouter.pop();
        } else {
          read.requestAll();
        }
      },
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Text(
          _buildMessage(read),
          style: const TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
    );
  }

  String _buildMessage(PermissionListViewModel read) {
    if (read.shouldRecheck) {
      return '새로고침';
    } else if (read.canSkipAll) {
      return '다음';
    } else {
      return '모두 허용하기';
    }
  }
}
