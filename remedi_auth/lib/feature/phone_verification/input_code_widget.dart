import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class InputCodeWidget extends StatefulWidget {
  final FocusNode focusNode;
  final Function(String) onCodeChanged;
  final TextEditingController controller;

  const InputCodeWidget({
    Key? key,
    required this.focusNode,
    required this.onCodeChanged,
    required this.controller,
  }) : super(key: key);

  @override
  InputCodeState createState() {
    return InputCodeState();
  }
}

class InputCodeState extends State<InputCodeWidget> {
  List<_InputCodeBox> inputs = [];

  @override
  void initState() {
    super.initState();
    inputs.addAll([
      _InputCodeBox(focused: true),
      _InputCodeBox(),
      _InputCodeBox(),
      _InputCodeBox(),
      _InputCodeBox(),
      _InputCodeBox(),
    ]);

    widget.controller.addListener(() {
      dev.log(widget.controller.text, name: "input code");
      setState(() {
        int i = 0;
        List<String> strings =
            widget.controller.text.characters.toList(growable: false);

        inputs = inputs.map<_InputCodeBox>((w) {
          var ret = _InputCodeBox(
            text: i < widget.controller.text.length ? "${strings[i]}" : "",
            focused: i == widget.controller.text.length ||
                (i == 5 && widget.controller.text.length == 6),
            enabled: false,
          );
          i++;
          return ret;
        }).toList(growable: false);

        widget.onCodeChanged(widget.controller.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.bottomCenter,
      child: Column(children: [
        SizedBox(
          height: (16),
          child: Stack(
            children: [
              Container(
                height: 14,
                child: MediaQuery(
                  data: MediaQueryData(textScaleFactor: 0.1),
                  child: TextField(
                    autofocus: false,
                    style: TextStyle(fontSize: 1),
                    focusNode: widget.focusNode,
                    controller: widget.controller,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                    ],
                    // keyboardType: TextInputType.number,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: false),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 16,
                color: Colors.white,
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            widget.focusNode.requestFocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(children: inputs),
          ),
        ),
      ]),
    );
  }

  String getCode() {
    return "";
  }

  _disableAll() {
    setState(() {
      inputs = inputs
          .map((e) => _InputCodeBox(
                text: e.text,
                focused: e.focused,
                enabled: false,
              ))
          .toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _InputCodeBox extends StatelessWidget {
  final String? text;
  final bool focused;
  final bool enabled;

  _InputCodeBox({
    this.text,
    this.focused = false,
    this.enabled = true,
  });

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.fromBorderSide(BorderSide(
            width: _borderWidth(),
            color: _borderColor(),
          )),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.all(4),
        child: MediaQuery(
          data: MediaQueryData(textScaleFactor: 1),
          child: Text(
            text ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
              height: 1.3,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Color _borderColor() {
    if (focused) {
      return Colors.red;
    }

    if (text?.isNotEmpty ?? false) {
      return Colors.blue;
    }
    return Colors.grey;
  }

  double _borderWidth() {
    if (focused) {
      return 2;
    }

    if (text?.isNotEmpty ?? false) {
      return 1;
    }

    return 1;
  }
}
