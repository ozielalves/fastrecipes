import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_icons.dart';
import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/models/user.dart';
import 'package:fastrecipes/views/content/components/widgets.dart';
import 'package:flutter/material.dart';

import 'empty_state.dart';
import 'recipe_card.dart';
import 'recipe_modal.dart';

class ListContentComponent extends StatelessWidget {
  final bool isLoggedIn;
  final bool isRecipesRequestLoading;
  final List<Recipe> recipes;
  final Recipe selectedRecipe;
  final Function(Recipe) setSelectedRecipe;
  final IUser userLoggedIn;
  final Function updateUser;
  final Function updateRecipesList;

  const ListContentComponent(
      {Key key,
      @required this.isLoggedIn,
      @required this.isRecipesRequestLoading,
      @required this.recipes,
      @required this.selectedRecipe,
      @required this.setSelectedRecipe,
      @required this.userLoggedIn,
      @required this.updateUser,
      @required this.updateRecipesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !isLoggedIn
            ? Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.primaryColor,
                  ),
                ),
              )
            : Expanded(
                child: isRecipesRequestLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.primaryColor,
                        ),
                      )
                    : ShaderMask(
                        shaderCallback: (Rect rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black
                            ],
                            stops: [
                              0.0,
                              0.05,
                              1.0,
                              1.0
                            ], // 10% purple, 80% transparent, 10% purple
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: RefreshIndicator(
                              backgroundColor: AppColors.primaryColor,
                              onRefresh: updateRecipesList,
                              child: recipes != null && recipes.length > 0
                                  ? ListView.builder(
                                      itemCount: recipes.length,
                                      itemBuilder: (context, index) =>
                                          RecipeCard(
                                            recipe: recipes[index],
                                            selected:
                                                selectedRecipe == recipes[index]
                                                    ? true
                                                    : false,
                                            onSelected: () {
                                              setSelectedRecipe(recipes[index]);
                                              showRecipeModal(
                                                  context, recipes[index]);
                                            },
                                            userLoggedIn: userLoggedIn,
                                            updateUser: updateUser,
                                          ))
                                  : EmptyState(
                                      icon: AppIcon(
                                        AppIcons.heartEmptyStateIcon,
                                        size: Size.square(80),
                                      ),
                                      title: "Nenhuma receita favoritada",
                                      description:
                                          "Favorite as receitas que você mais gostar para lista-las aqui"),
                            )),
                      ),
              ),
      ],
    );
  }
}
