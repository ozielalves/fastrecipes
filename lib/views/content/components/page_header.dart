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
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: AppColors.primaryColor,
          ),
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
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: AppColors.textColor)),
        signOut != null
            ? signOut
            : Spacer(
                flex: 2,
              ),
      ],
    );
  }
}
