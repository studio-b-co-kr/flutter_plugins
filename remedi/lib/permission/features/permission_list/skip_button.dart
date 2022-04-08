part of 'permission_list.dart';

class SkipButton extends ViewModelView<PermissionListViewModel> {
  const SkipButton({Key? key}) : super(key: key);

  @override
  Widget buildChild(BuildContext context, PermissionListViewModel watch,
      PermissionListViewModel read) {
    return Container(
      alignment: Alignment.centerRight,
      width: double.infinity,
      child: InkWell(
        onTap: watch.canSkipAll
            ? () async {
                await PermissionStorage.skip();
                RemediRouter.pop();
              }
            : null,
        child: watch.canSkipAll
            ? Container(
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
              )
            : Container(),
      ),
    );
  }
}
