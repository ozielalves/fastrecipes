import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  final String title;
  final String content;
  final String primaryButtonText;
  final Function primaryButtonAction;
  final String secondaryButtonText;
  final Function secondaryButtonAction;

  WarningDialog(
      {this.title,
      this.content,
      this.primaryButtonText,
      this.primaryButtonAction,
      this.secondaryButtonText,
      this.secondaryButtonAction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(title, style: TextStyle(color: Color(0xFF333333))),
      content: Text(content, style: TextStyle(color: Color(0xFF7B7B7B))),
      actions: <Widget>[
        TextButton(
            child: Text(secondaryButtonText,
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: secondaryButtonAction),
        TextButton(
          child: Text(primaryButtonText,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          onPressed: primaryButtonAction,
        )
      ],
    );
  }
}
