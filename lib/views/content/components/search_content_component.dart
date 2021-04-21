import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/views/content/components/recipe_modal.dart';
import 'package:fastrecipes/views/content/components/widgets.dart';
import 'package:flutter/material.dart';

import 'empty_state.dart';
import 'recipe_card.dart';
import 'search_bar_component.dart';

class SearchContentComponent extends StatefulWidget {
  final List<Recipe> recipes;
  final Recipe selectedRecipe;
  final bool isRecipesRequestLoading;

  const SearchContentComponent(
      {Key key,
      @required this.recipes,
      this.selectedRecipe,
      @required this.isRecipesRequestLoading})
      : super(key: key);

  @override
  _SearchContentComponentState createState() => _SearchContentComponentState();
}

class _SearchContentComponentState extends State<SearchContentComponent> {
  List<Recipe> filteredRecipes;
  Recipe selectedRecipe;

  // Controller
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredRecipes = widget.recipes;
    super.initState();
  }

  void handleSearch(String value) {
    if (value.length > 0) {
      setState(() {
        filteredRecipes = widget.recipes
            .where((r) => r.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredRecipes = widget.recipes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SearchBarComponent(
            searchController: searchController,
            handleSearch: handleSearch,
          ),
          Expanded(
            child: widget.isRecipesRequestLoading
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
                      child: ListView(
                        children: <Widget>[
                          if (filteredRecipes != null &&
                              filteredRecipes.length > 0 &&
                              searchController.text.length > 0)
                            for (var recipe in filteredRecipes)
                              RecipeCard(
                                recipe: recipe,
                                selected:
                                    selectedRecipe == recipe ? true : false,
                                onSelected: () {
                                  setState(() {
                                    selectedRecipe = recipe;
                                  });
                                  showRecipeModal(context, recipe);
                                },
                              )
                          else
                            EmptyState(
                                icon: Icon(
                                  Icons.list_alt,
                                  color: AppColors.emptyStateIconColor,
                                  size: 80,
                                ),
                                title: "Nenhuma receita encontrada",
                                description:
                                    "Castre uma receita ou realize uma nova busca"),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
