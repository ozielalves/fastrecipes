import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'action_button.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final VoidCallback onGoBack;
  final ActionButton signOut;

  PageHeader({this.title, this.onGoBack, this.signOut});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActionButton(
          action: onGoBack,
          icon: Icons.arrow_back,
          iconColor: AppColors.primaryColor,
          minWidth: double.minPositive,
          buttonColor: Colors.transparent,
          borderRadius: 50,
          outlined: true,
          padding: EdgeInsets.all(0),
        ),
        if (signOut == null) Spacer(),
        Text(title,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: AppColors.primaryColor)),
        signOut != null
            ? signOut
            : Spacer(
                flex: 2,
              ),
      ],
    );
  }
}
