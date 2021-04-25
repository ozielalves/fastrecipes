import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_icons.dart';
import 'package:fastrecipes/core/theme/app_typhography.dart';
import 'package:fastrecipes/models/recipe.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class RecipeCardInfoList extends StatelessWidget {
  final Recipe recipe;

  const RecipeCardInfoList({Key key, @required this.recipe}) : super(key: key);

  String _ingredientsToString() {
    String finalIngredients;
    for (var i = 0; i < recipe.ingredients.length; i++) {
      if (recipe.ingredients[i].substituteFood != null) {
        if (i < recipe.ingredients.length - 1) {
          if (finalIngredients != null) {
            finalIngredients =
                '$finalIngredients, ${recipe.ingredients[i].food} ou ${recipe.ingredients[i].substituteFood}';
          } else {
            finalIngredients =
                '${recipe.ingredients[i].food} ou ${recipe.ingredients[i].substituteFood}';
          }
        } else {
          if (finalIngredients != null) {
            finalIngredients =
                '$finalIngredients, ${recipe.ingredients[i].food} ou ${recipe.ingredients[i].substituteFood}.';
          } else {
            finalIngredients =
                '${recipe.ingredients[i].food} ou ${recipe.ingredients[i].substituteFood}.';
          }
        }
      } else {
        if (i < recipe.ingredients.length - 1) {
          if (finalIngredients != null) {
            finalIngredients =
                '$finalIngredients, ${recipe.ingredients[i].food}';
          } else {
            finalIngredients = '${recipe.ingredients[i].food}';
          }
        } else {
          if (finalIngredients != null) {
            finalIngredients =
                '$finalIngredients, ${recipe.ingredients[i].food}.';
          } else {
            finalIngredients = '${recipe.ingredients[i].food}.';
          }
        }
      }
    }
    return finalIngredients;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 115.0),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: (width / 2.7) - 20, right: 20),
                      child: TabBar(
                        labelStyle: AppTyphography.bodyText(context),
                        labelPadding: EdgeInsets.zero,
                        indicatorPadding: EdgeInsets.zero,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        labelColor: AppColors.textColor,
                        unselectedLabelColor: AppColors.grey,
                        indicatorColor: AppColors.primaryColor,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(
                            child: Text('1'),
                          ),
                          Tab(
                            child: Text('2'),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    RecipeCardInfo(
                      children: <Widget>[
                        ListItem(
                          icon: AppIcons.personFilledOutlined,
                          title: 'Criador(a)',
                          subtitle: recipe.creatorName,
                        ),
                        ListItem(
                          icon: AppIcons.timeFilledOutlined,
                          title: 'Tempo',
                          subtitle: '${recipe.preparationTime} minutos',
                        ),
                        ListItem(
                          icon: AppIcons.carrotFilledOutlined,
                          title: 'Ingredientes',
                          subtitle: _ingredientsToString(),
                        ),
                        ListItem(
                          icon: recipe.dificultyLevel == 'Fácil'
                              ? AppIcons.easyDificultyOutlined
                              : recipe.dificultyLevel == 'Médio'
                                  ? AppIcons.mediumDificultyOutlined
                                  : AppIcons.hardDificultyOutlined,
                          title: 'Dificuldade',
                          subtitle: recipe.dificultyLevel,
                        ),
                      ],
                    ),
                    RecipeCardInfo(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppIcon(AppIcons.recipePreparationOutlined,
                                  size: Size.square(40)),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text('Modo de preparo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: AppColors.textColor)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(recipe.preparation,
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.textColor)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeCardInfo extends StatelessWidget {
  final List<Widget> children;

  const RecipeCardInfo({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(11.5, 20, 11.5, 60),
      height: 284.0,
      width: width * 0.95,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(width: 1.5, color: AppColors.borderColor)),
      child: Expanded(
        child: ScrollConfiguration(
          behavior: NoGlowBehaviour(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;

  const ListItem({Key key, this.title, this.subtitle, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: AppTyphography.bodyTextSemiBold(context),
          ),
          subtitle: Text(subtitle),
          leading: AppIcon(icon, size: Size.square(40)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            color: AppColors.grey,
          ),
        )
      ],
    );
  }
}
