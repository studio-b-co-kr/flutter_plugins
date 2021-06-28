import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:remedi_widgets/remedi_widgets.dart';

// ignore: must_be_immutable
class InputCodeWidget extends StatefulWidget {
  final String confirmVerificationCode;
  final String inputPhoneVerificationCode;

  const InputCodeWidget(
      {Key? key,
      required this.confirmVerificationCode,
      required this.inputPhoneVerificationCode})
      : super(key: key);

  @override
  InputCodeState createState() {
    return InputCodeState();
  }
}

class InputCodeState extends State<InputCodeWidget> {
  bool? _showRequest = false;
  TextEditingController? _controller = TextEditingController();
  TapGestureRecognizer? _basePressRecognizer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: (16)),
      child: Column(children: [
        SizedBox(height: (16)),
        FixedScaleText(
            text: Text("${2} : ${00}",
                style: TextStyle(color: Colors.blue.shade900, fontSize: (14)))),
        Form(child: TextField(
          controller: _controller,
          autofocus: true,
          readOnly: false,
          maxLength: 6,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          onChanged: (number) {},
        ),),
        // TODO show confirm button
      ]),
    );
  }
}
