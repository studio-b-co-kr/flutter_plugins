part of 'permission_list.dart';

class PermissionListItem extends ViewModelView<PermissionListViewModel> {
  final AppPermission permission;

  const PermissionListItem({Key? key, required this.permission})
      : super(key: key);

  @override
  Widget buildChild(BuildContext context, PermissionListViewModel watch,
      PermissionListViewModel read) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          read.request(permission);
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: Icon(
                  permission.icon,
                  size: 24,
                ),
              ),
              Text(
                permission.title ?? "",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ]),
            const SizedBox(height: 16),
            Container(
                margin: const EdgeInsets.only(left: 8),
                child: Text(permission.description ?? "")),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  stateIcon(permission),
                  const SizedBox(width: 8),
                  Expanded(child: Text(permission.stateMessage))
                ],
              ),
            ),
            permission.state == AppPermissionState.permanentlyDenied
                ? Container(
                    margin: const EdgeInsets.only(top: 16, left: 8),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "앱 세팅에서 가서 권한을 부여해주세요",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_sharp,
                              color: Colors.blue, size: 16)
                        ]),
                  )
                : Container(),
          ]),
        ),
      ),
    );
  }

  Widget stateIcon(AppPermission permission) {
    IconData icon = Icons.check_circle_outline;
    Color iconColor = Colors.grey;
    switch (permission.state) {
      case AppPermissionState.granted:
        iconColor = Colors.green;
        break;
      case AppPermissionState.denied:
      case AppPermissionState.permanentlyDenied:
        if (permission.mandatory) {
          icon = Icons.error_outline_sharp;
          iconColor = Colors.red;
        } else {
          icon = Icons.error_outline_sharp;
          iconColor = Colors.grey;
        }
        break;
      default:
        break;
    }
    return Icon(
      icon,
      size: 20,
      color: iconColor,
    );
  }
}
