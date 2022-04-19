part of 'permission_list.dart';

class PermissionList extends ViewModelView<PermissionListViewModel> {
  const PermissionList({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildChild(BuildContext context, PermissionListViewModel watch,
      PermissionListViewModel read) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 32),
        itemCount: read.permissionList.length,
        itemBuilder: (context, index) {
          return PermissionListItem(
            permission: watch.permissionList[index],
          );
        });
  }
}
