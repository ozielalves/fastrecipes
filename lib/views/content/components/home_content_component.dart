import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/views/content/components/recipe_card.dart';
import 'package:fastrecipes/views/content/components/recipe_modal.dart';
import 'package:fastrecipes/views/content/components/widgets.dart';
import 'package:flutter/material.dart';

import 'empty_state.dart';
import 'tabbar_component.dart';

class HomeContentComponent extends StatefulWidget {
  final bool isLoggedIn;
  final List<Recipe> recipes;
  final Recipe selectedRecipe;
  final bool isRecipesRequestLoading;

  const HomeContentComponent(
      {Key key,
      @required this.isLoggedIn,
      this.recipes,
      this.selectedRecipe,
      this.isRecipesRequestLoading})
      : super(key: key);

  @override
  _HomeContentComponentState createState() => _HomeContentComponentState();
}

class _HomeContentComponentState extends State<HomeContentComponent>
    with SingleTickerProviderStateMixin {
  Recipe selectedRecipe;

  // Controllers
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    selectedRecipe = widget.selectedRecipe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          AppBarContent(
            tabController: tabController,
            onTap: (index) {},
          ),
          !widget.isLoggedIn
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                )
              : Expanded(
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
                                if (widget.recipes != null &&
                                    widget.recipes.length > 0)
                                  for (var recipe in widget.recipes)
                                    RecipeCard(
                                      recipe: recipe,
                                      selected: selectedRecipe == recipe
                                          ? true
                                          : false,
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
