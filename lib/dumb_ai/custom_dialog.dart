import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  const CustomDialog(this.title, this.content, this.callback,
      [this.actionText = "Reset"]);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
         ElevatedButton(
          onPressed: callback,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red)
          ),
         // color: Colors.white,
          child: Text(actionText),
        )
      ],
    );
  }
}