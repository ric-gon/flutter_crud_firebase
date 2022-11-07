import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class CustomAlertDialog extends StatefulWidget {
  String text1, text2, textButton1;

  // ignore: use_key_in_widget_constructors
  CustomAlertDialog(
      {required this.text1, required this.text2, required this.textButton1});

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.text1),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(widget.text2),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text(widget.textButton1),
            onPressed: () {
              if (widget.textButton1 == "Home") {
                Navigator.popUntil(context, (route) => route.isFirst);
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
}
