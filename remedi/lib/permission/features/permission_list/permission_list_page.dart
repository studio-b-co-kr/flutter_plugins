import 'package:flutter/material.dart';
import 'package:remedi/remedi.dart';

import '../../app_permission.dart';
import 'permission_list_view_model.dart';

// ignore: must_be_immutable
class PermissionListPage extends ViewModelBuilder<PermissionListViewModel> {
  PermissionListPage({
    Key? key,
    required PermissionListViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, PermissionListViewModel read) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SkipButton(onTap: () {}),
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
              child: PermissionList(),
            ),
          )
        ]),
      ),
    );
  }
}

class SkipButton extends ViewModelView<PermissionListViewModel> {
  final void Function() onTap;

  const SkipButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: double.infinity,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  '건너뛰기',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                  color: Colors.blue,
                )
              ]),
        ),
      ),
    );
  }

  @override
  Widget buildChild(BuildContext context, PermissionListViewModel watch,
      PermissionListViewModel read) {
    // TODO: implement buildChild
    throw UnimplementedError();
  }
}

class GrantAllButton extends StatelessWidget {
  final void Function()? onTab;

  const GrantAllButton({Key? key, this.onTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: const Text(
          '모두 허용하기',
          style: TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
    );
  }
}

class PermissionList extends ViewModelView<PermissionListViewModel> {
  const PermissionList({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildChild(BuildContext context, PermissionListViewModel watch,
      PermissionListViewModel read) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 32),
      itemCount: read.permissionList.length,
      itemBuilder: (context, index) {
        return PermissionListItem(
          permission: watch.permissionList[index],
          onTap: (permission) {
            read.request(permission);
          },
        );
      },
    );
  }
}

class PermissionListItem extends StatelessWidget {
  final void Function(AppPermission permission)? onTap;
  final AppPermission permission;

  const PermissionListItem(
      {Key? key, required this.permission, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {},
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
                        children: [
                          Text(
                            "앱 세팅에서 가서 권한을 부여해주세요",
                            style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward_ios_sharp,
                              color: Colors.blue.shade700, size: 16)
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
          iconColor = Colors.grey;
        } else {
          icon = Icons.error_outline_sharp;
          iconColor = Colors.red;
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
