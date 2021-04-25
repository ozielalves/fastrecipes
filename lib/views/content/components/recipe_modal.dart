import 'dart:ui';

import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'recipe_card_info_list.dart';

dynamic showRecipeModal(BuildContext context, Recipe recipe) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: CircleBorder(),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(
              margin: EdgeInsets.only(top: 150),
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                      top: -100,
                      left: 0,
                      right: 0,
                      child:
                          SvgPicture.asset('assets/images/RecipeAvatar.svg')),
                  Container(
                      margin: EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 23, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(recipe.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: AppColors.textColor)),
                              ],
                            ),
                          ),
                        ],
                      )),
                  RecipeCardInfoList(
                    recipe: recipe,
                  ),
                ],
              )),
        );
      });
}
