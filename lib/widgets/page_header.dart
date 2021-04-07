import 'package:flutter/material.dart';

import 'action_button.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final Function onGoBack;

  PageHeader({this.title, this.onGoBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ActionButton(
            action: onGoBack,
            icon: Icons.arrow_back,
            buttonColor: Theme.of(context).primaryColor),
        SizedBox(
          width: 50,
        ),
        Text(title,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: Theme.of(context).primaryColor))
      ],
    );
  }
}
