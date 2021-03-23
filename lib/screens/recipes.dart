import 'package:fastrecipes/helpers/api_manager.dart';
import 'package:fastrecipes/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:fastrecipes/widgets/widgets.dart';

import 'recipe_register.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  ApiManager apiManager = ApiManager();

  List<Recipe> recipes = [];
  List<Recipe> filteredRecipes = [];

  // Search controller
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateList();
  }

  void updateList() {
    apiManager.getRecipes().then((list) {
      setState(() {
        recipes = list;
        filteredRecipes = list;
      });
    });
  }

  void handdleSearch(String value) {
    if (value.length > 0) {
      setState(() {
        filteredRecipes = recipes
            .where((c) => c.name.toLowerCase().contains(value.toLowerCase()))
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
            /* padding: EdgeInsets.fromLTRB(19, 32, 19, 19), */
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
                    child: PageHeader(title: 'Recipes'),
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                  /* Expanded(
                    child: ScrollConfiguration(
                      behavior: NoGlowBehaviour(),
                      child: ListView(
                        children: <Widget>[
                          if (filteredRecipes != null &&
                              filteredRecipes.length > 0)
                            for (var recipe in filteredRecipes)
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 19),
                                /* child: ContactCard(
                                    contact: contact,
                                    updateList: updateList,
                                    showOptions: showOptions), */
                              )
                          else
                            Container(
                              padding: EdgeInsets.all(40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nenhuma receita encontrada",
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xFF333333)),
                                  ),
                                  Text(
                                    "Castre uma receita ou realize uma nova busca",
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
                  ), */
                ],
              ),
            ),
          ],
        )));
  }
}
