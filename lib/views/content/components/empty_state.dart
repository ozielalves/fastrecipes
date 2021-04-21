import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final Icon icon;
  final String title;
  final String description;

  EmptyState({this.icon, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(height: 9),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                color: AppColors.textColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 9),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: AppColors.textFadedColor),
          )
        ],
      ),
    );
  }
}
