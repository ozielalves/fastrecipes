import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String pathIcons = "assets/icons/";

class AppIcons {
  static const addFilled = "${pathIcons}AddFilledIcon.svg";
  static const addStroked = "${pathIcons}AddStrokedIcon.svg";
  static const avatar = "${pathIcons}AvatarIcon.svg";
  static const easyDificulty = "${pathIcons}EasyDificultyIcon.svg";
  static const hardDificulty = "${pathIcons}HardDificultyIcon.svg";
  static const mediumDificulty = "${pathIcons}MediumDificultyIcon.svg";
  static const heartFilled = "${pathIcons}HeartFilledIcon.svg";
  static const heartStroked = "${pathIcons}HeartStrokedIcon.svg";
  static const homeFilled = "${pathIcons}HomeFilledIcon.svg";
  static const homeStroked = "${pathIcons}HomeStrokedIcon.svg";
  static const personFilled = "${pathIcons}PersonFilledIcon.svg";
  static const personStroked = "${pathIcons}PersonStrokedIcon.svg";
  static const recipeFilled = "${pathIcons}RecipeFilledIcon.svg";
  static const recipeStroked = "${pathIcons}RecipeStrokedIcon.svg";
  static const searchFilled = "${pathIcons}SearchFilledIcon.svg";
  static const searchStroked = "${pathIcons}SearchStrokedIcon.svg";
  static const time = "${pathIcons}TimeIcon.svg";
  static const carrotFilledOutlined = "${pathIcons}CarrotFilledOutlined.svg";
  static const easyDificultyOutlined = "${pathIcons}EasyDificultyOutlined.svg";
  static const hardDificultyOutlined = "${pathIcons}HardDificultyOutlined.svg";
  static const mediumDificultyOutlined =
      "${pathIcons}MediumDificultyOutlined.svg";
  static const personFilledOutlined = "${pathIcons}PersonFilledOutlined.svg";
  static const timeFilledOutlined = "${pathIcons}TimeFilledOutlined.svg";
  static const recipePreparationOutlined =
      "${pathIcons}RecipePreparationOutlined.svg";
  static const heartEmptyStateIcon = "${pathIcons}HeartEmptyStateIcon.svg";
}

class AppIcon extends StatelessWidget {
  final String icon;
  final Size size;
  final Color color;

  const AppIcon(this.icon, {Key key, this.size, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: size?.height ?? 24,
      width: size?.width ?? 24,
      color: color,
    );
  }
}
