import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class InputCodeWidget extends StatefulWidget {
  final FocusNode focusNode;
  final Function(String) onCodeChanged;
  final TextEditingController controller;
  String code;
  bool enabled;

  InputCodeWidget({
    Key? key,
    required this.focusNode,
    required this.onCodeChanged,
    required this.controller,
    required this.code,
    this.enabled = true,
  }) : super(key: key);

  @override
  InputCodeState createState() {
    return InputCodeState();
  }
}

class InputCodeState extends State<InputCodeWidget> {
  @override
  void initState() {
    widget.controller.text = widget.code;
    super.initState();
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
                    enableSuggestions: false,
                    enableInteractiveSelection: false,
                    autofocus: false,
                    style: TextStyle(fontSize: 1),
                    focusNode: widget.focusNode,
                    controller: widget.controller,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                    ],
                    // keyboardType: TextInputType.number,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    onChanged: (code) {
                      dev.log(widget.controller.text, name: "input code");
                      setState(() {
                        widget.code = code;
                      });

                      widget.onCodeChanged(code);
                    },
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
        _buildCodeBoxes(context, widget.code),
      ]),
    );
  }

  String getCode() {
    return "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildCodeBoxes(BuildContext context, String code) {
    int focusedIndex = widget.code.length == 6 ? (6 - 1) : widget.code.length;
    var codeUnits = code.split("");
    List<_InputCodeBox> inputs = [];
    for (int index = 0; index < 6; index++) {
      String text = "";
      if (index < codeUnits.length) {
        text = "${codeUnits[index]}";
      }

      bool focused = index == focusedIndex;

      _InputCodeBox box = _InputCodeBox(
        text: text,
        focused: focused,
        enabled: widget.enabled,
      );

      inputs.add(box);
    }

    return InkWell(
      onTap: widget.enabled
          ? () {
              widget.focusNode.requestFocus();
            }
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: inputs),
      ),
    );
  }
}

class _InputCodeBox extends StatelessWidget {
  final String? text;
  final bool focused;
  final bool enabled;

  _InputCodeBox({
    this.text = "",
    this.focused = false,
    this.enabled = true,
  });

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: enabled ? null : Colors.grey.shade50,
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
    if (!enabled) {
      return Colors.transparent;
    }

    if (focused) {
      return Colors.red;
    }

    if (text?.isNotEmpty ?? false) {
      return Colors.blue;
    }
    return Colors.grey;
  }

  double _borderWidth() {
    if (!enabled) {
      return 0;
    }

    if (focused) {
      return 2;
    }

    if (text?.isNotEmpty ?? false) {
      return 1;
    }

    return 1;
  }
}
