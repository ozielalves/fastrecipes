import 'package:fastrecipes/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets.dart';

dynamic showRecipeModal(BuildContext context, Recipe recipe) {
  final double cWidth = MediaQuery.of(context).size.width;
  final double cHeight = MediaQuery.of(context).size.height;
  return showModalBottomSheet(
      isScrollControlled: true,
      /* elevation: 6, */
      context: context,
      shape: CircleBorder(),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            margin: EdgeInsets.only(top: 300),
            decoration: BoxDecoration(
                color: Color(0xFFEDEDED),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                    top: -100,
                    left: 0,
                    right: 0,
                    child: SvgPicture.asset('assets/images/RecipeAvatar.svg')),
                Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 23),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(recipe.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Color(0xFF333333))),
                            ],
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 150),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(11.5, 20, 11.5, 60),
                        height: 284.0,
                        width: cWidth * 0.95,
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: kElevationToShadow[3]),
                        child: Expanded(
                          child: ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 9),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/AvatarIcon.svg'),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xFF333333)),
                                                children: <TextSpan>[
                                              TextSpan(
                                                text: 'Criador(a): ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(
                                                  text: '${recipe.creatorName}')
                                            ]))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 9),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/TimeIcon.svg'),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xFF333333)),
                                                children: <TextSpan>[
                                              TextSpan(
                                                text: 'Tempo: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(
                                                  text:
                                                      '${recipe.preparationTime} min')
                                            ]))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 9),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/FoodIcon.svg'),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        Container(
                                          width: 250,
                                          child: RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xFF333333)),
                                                  children: <TextSpan>[
                                                TextSpan(
                                                  text: 'Ingredientes: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                for (var i = 0;
                                                    i <
                                                        recipe
                                                            .ingredients.length;
                                                    i++)
                                                  recipe.ingredients[i]
                                                              .substituteFood !=
                                                          null
                                                      ? i <
                                                              recipe.ingredients
                                                                      .length -
                                                                  1
                                                          ? TextSpan(
                                                              text:
                                                                  '${recipe.ingredients[i].food} ou ${recipe.ingredients[i].substituteFood}, ')
                                                          : TextSpan(
                                                              text:
                                                                  '${recipe.ingredients[i].food} ou ${recipe.ingredients[i].substituteFood}.')
                                                      : i <
                                                              recipe.ingredients
                                                                      .length -
                                                                  1
                                                          ? TextSpan(
                                                              text:
                                                                  '${recipe.ingredients[i].food}, ')
                                                          : TextSpan(
                                                              text:
                                                                  '${recipe.ingredients[i].food}. '),
                                              ])),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 9),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(recipe
                                                    .dificultyLevel ==
                                                'Fácil'
                                            ? 'assets/images/EasyDificultyIcon.svg'
                                            : recipe.dificultyLevel == 'Médio'
                                                ? 'assets/images/MediumDificultyIcon.svg'
                                                : 'assets/images/HardDificultyIcon.svg'),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xFF333333)),
                                                children: <TextSpan>[
                                              TextSpan(
                                                text: 'Dificuldade:',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(
                                                  text:
                                                      ' ${recipe.dificultyLevel}')
                                            ]))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(11.5, 20, 11.5, 60),
                        padding: EdgeInsets.all(20),
                        width: cWidth * 0.95,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: kElevationToShadow[3]),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Modo de preparo',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color(0xFF333333))),
                                ],
                              ),
                            ),
                            /* Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: */
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(recipe.preparation,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xFF333333))),
                            ),
                            /*  ),
                                ), */
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
        /* ); */
      });
}
