import 'package:flutter/cupertino.dart';

class ForceUpdateWrapper extends StatelessWidget {
  static const routeName = '/force_update';
  final Widget forceUpdatePage;

  const ForceUpdateWrapper({Key? key, required this.forceUpdatePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return forceUpdatePage;
  }
}
