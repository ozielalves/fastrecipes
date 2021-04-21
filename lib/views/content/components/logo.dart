import 'package:fastrecipes/core/theme/app_typhography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

dynamic buildLogo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(
          right: 12.0,
        ),
        child: SvgPicture.asset(
          'assets/images/bowl.svg',
        ),
      ),
      Text("FastRecipe", style: AppTyphography.h1),
    ],
  );
}
