/* import 'package:fastrecipes/helpers/api_manager.dart'; */
import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/widgets/action_button.dart';
import 'package:fastrecipes/widgets/Input.dart';
import 'package:fastrecipes/widgets/page_header.dart';
import 'package:fastrecipes/widgets/recipe_card.dart';
import 'package:fastrecipes/widgets/recipe_modal.dart';
import 'package:flutter/material.dart';
import 'package:fastrecipes/widgets/widgets.dart';
import 'package:fastrecipes/provider/recipe.dart';

import 'recipe_register.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  ApiManager apiManager = ApiManager();

  List<Recipe> recipes = [];
  List<Recipe> filteredRecipes = [];
  Recipe selectedRecipe;
  bool isRecipesRequestLoading = false;

  // Search controller
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateList();
  }

  void _setRecipesRequestLoading(bool value) {
    setState(() {
      isRecipesRequestLoading = value;
    });
  }

  Future<void> _updateList() async {
    _setRecipesRequestLoading(true);
    await apiManager.getRecipes().then((list) {
      setState(() {
        recipes = list;
        filteredRecipes = list;
      });
    });
    _setRecipesRequestLoading(false);
  }

  void handdleSearch(String value) {
    if (value.length > 0) {
      setState(() {
        filteredRecipes = recipes
            .where((r) => r.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredRecipes = recipes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFF3E0),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: ActionButton(
            icon: Icons.add,
            iconSize: 45,
            buttonColor: Theme.of(context).primaryColor,
            action: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RecipeRegister()));
            },
          ),
        ),
        body: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: kElevationToShadow[3],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(19, 54, 19, 19),
                        child: PageHeader(
                            onGoBack: () {
                              Navigator.of(context).pop();
                            },
                            title: '   Receitas'),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(19, 0, 19, 15),
                        child: Row(
                          children: [
                            Input(
                              controller: searchController,
                              borderRadius: 50.0,
                              label: 'O que tem na sua geladeira?',
                              labelFontSize: 18,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              icon: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                              onChanged: (text) {
                                handdleSearch(text);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: isRecipesRequestLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
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
                                    searchController.text.length <= 0)
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 19),
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Color(0xFF333333)),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: 'Mais',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(text: ' recentes')
                                          ]))),
                                if (filteredRecipes != null &&
                                    filteredRecipes.length > 0)
                                  for (var recipe in filteredRecipes)
                                    RecipeCard(
                                      recipe: recipe,
                                      selected: selectedRecipe == recipe
                                          ? true
                                          : false,
                                      onSelected: () {
                                        setState(() {
                                          selectedRecipe = recipe;
                                          showRecipeModal(context, recipe);
                                        });
                                      },
                                    )
                                else
                                  Container(
                                    padding: EdgeInsets.all(30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.list_alt,
                                          color: Color(0xFF7B7B7B),
                                          size: 80,
                                        ),
                                        SizedBox(height: 9),
                                        Text(
                                          "Nenhuma receita encontrada",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Color(0xFF333333),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 9),
                                        Text(
                                          "Castre uma receita ou realize uma nova busca",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF969696),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            )));
  }
}
