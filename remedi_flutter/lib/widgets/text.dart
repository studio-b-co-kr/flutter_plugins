import 'package:flutter/widgets.dart';

class FixedScaleText extends StatelessWidget {
  final Text text;

  const FixedScaleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(textScaleFactor: 1),
      child: text,
    );
  }
}
