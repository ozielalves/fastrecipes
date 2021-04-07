import 'package:fastrecipes/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'action_button.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool selected;
  final Function onSelected;

  RecipeCard({this.recipe, this.selected, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        margin: EdgeInsets.fromLTRB(19, 19, 19, 0),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: selected
                ? Border.all(width: 1.5, color: Color(0xFF7B7B7B))
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/images/FoodAvatar.svg'),
            SizedBox(
              width: 23,
            ),
            Container(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(recipe.name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF333333))),
                      Text(recipe.creatorName,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6B6B6B))),
                    ],
                  ),

                  /* SizedBox(height: 22), */
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Text(
                            '${recipe.preparationTime} min - ${recipe.dificultyLevel}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B6B6B))),
                        SizedBox(width: 8),
                        SvgPicture.asset(
                          recipe.dificultyLevel == 'Fácil'
                              ? 'assets/images/easy_dark.svg'
                              : recipe.dificultyLevel == 'Médio'
                                  ? 'assets/images/medium_dark.svg'
                                  : recipe.dificultyLevel == 'Difícil'
                                      ? 'assets/images/hard_dark.svg'
                                      : 'assets/images/noLevel_dark.svg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ActionButton(
              icon: Icons.arrow_forward_ios,
              buttonColor: Theme.of(context).primaryColorLight,
              borderRadius: 10,
              action: onSelected,
            )
          ],
        ),
      ),
    );
  }
}