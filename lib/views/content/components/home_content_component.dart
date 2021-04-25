import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/models/user.dart';
import 'package:flutter/material.dart';

import 'list_content_component.dart';
import 'tabbar_component.dart';

class HomeContentComponent extends StatefulWidget {
  final bool isLoggedIn;
  final List<Recipe> recipes;
  final Recipe selectedRecipe;
  final bool isRecipesRequestLoading;
  final IUser userLoggedIn;
  final Function updateUser;
  final Function updateRecipesList;

  const HomeContentComponent(
      {Key key,
      @required this.isLoggedIn,
      this.recipes,
      this.selectedRecipe,
      this.isRecipesRequestLoading,
      @required this.userLoggedIn,
      @required this.updateUser,
      @required this.updateRecipesList})
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

  List<Recipe> _getFavoriteRecipes() {
    if (widget.userLoggedIn != null) {
      return widget.recipes
          .where(
              (e) => widget.userLoggedIn?.favoriteRecipesKeys?.contains(e.key))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            AppBarContent(),
            Expanded(
              child: TabBarView(children: [
                ListContentComponent(
                  isLoggedIn: widget.isLoggedIn,
                  isRecipesRequestLoading: widget.isRecipesRequestLoading,
                  recipes: widget.recipes,
                  selectedRecipe: selectedRecipe,
                  setSelectedRecipe: (recipe) {
                    setState(() {
                      selectedRecipe = recipe;
                    });
                  },
                  userLoggedIn: widget.userLoggedIn,
                  updateUser: widget.updateUser,
                  updateRecipesList: widget.updateRecipesList,
                ),
                ListContentComponent(
                  isLoggedIn: widget.isLoggedIn,
                  isRecipesRequestLoading: widget.isRecipesRequestLoading,
                  recipes: _getFavoriteRecipes(),
                  selectedRecipe: selectedRecipe,
                  setSelectedRecipe: (recipe) {
                    setState(() {
                      selectedRecipe = recipe;
                    });
                  },
                  userLoggedIn: widget.userLoggedIn,
                  updateUser: widget.updateUser,
                  updateRecipesList: widget.updateRecipesList,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
