part of 'permission_list.dart';

class GrantAllButton extends StatelessWidget {
  final void Function()? onTab;

  const GrantAllButton({Key? key, this.onTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: const Text(
          '모두 허용하기',
          style: TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
    );
  }
}
