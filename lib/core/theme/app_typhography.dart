import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTyphography {
  static TextStyle bodyText0(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor);
  }

  static TextStyle bodyText0SemiBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor);
  }

  static TextStyle bodyText0Bold(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor);
  }

  static TextStyle bodyText(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor);
  }

  static TextStyle bodyTextSemiBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor);
  }

  static TextStyle bodyTextBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor);
  }

  static TextStyle bodyText1SemiBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor);
  }

  static TextStyle bodyText1Bold(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor);
  }

  static TextStyle h1 = TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      color: AppColors.primaryColor);
  static TextStyle h3 = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.textColor);
  static TextStyle body1 = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.textColor);
  static TextStyle body1Bold = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      color: AppColors.textColor);
  static TextStyle body2 = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.textColor);
  static TextStyle body2Faded = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.grey);
}
