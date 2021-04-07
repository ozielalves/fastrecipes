import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/screens/recipes.dart';
import 'package:fastrecipes/widgets/action_button.dart';
import 'package:fastrecipes/widgets/food_chip.dart';
import 'package:fastrecipes/widgets/input.dart';
import 'package:fastrecipes/widgets/page_header.dart';
import 'package:fastrecipes/widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
/* import 'package:fastrecipes/helpers/api_manager.dart'; */
import 'package:fastrecipes/provider/recipe.dart';

class RecipeRegister extends StatefulWidget {
  @override
  _RecipeRegisterState createState() => _RecipeRegisterState();
}

class _RecipeRegisterState extends State<RecipeRegister> {
  ApiManager apiManager = ApiManager();

  List<Ingredient> ingredients = [];
  Recipe recipe;

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController recipeNameController = TextEditingController();
  TextEditingController foodController = TextEditingController();
  TextEditingController substituteFoodController = TextEditingController();
  TextEditingController preparationController = TextEditingController();
  TextEditingController preparationTimeController = TextEditingController();
  TextEditingController dificultyLevelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ingredients = [];
  }

  Future<void> _addIngredient() async {
    /* if (foodController != null && foodController.text.length > 0) {
      var ingredient = {};
      ingredient["foodId"] = await apiManager.addFood(foodController.text);
      if (substituteFoodController != null &&
          substituteFoodController.text.length > 0) {
        ingredient["substituteFoodId"] =
            await apiManager.addFood(substituteFoodController.text);
      }
      if (ingredient != null) { */
    setState(() {
      ingredients.insert(
          0,
          Ingredient(
              food: foodController.text,
              substituteFood: substituteFoodController.text.length > 0
                  ? substituteFoodController.text
                  : null));
      foodController.clear();
    });
    /* } */
    foodController.clear();
    substituteFoodController.clear();
    /* } */
  }

  Future<void> _createRecipe() async {
    if (nameController.text.length > 0 &&
        lastnameController.text.length > 0 &&
        recipeNameController.text.length > 0 &&
        preparationController.text.length > 0 &&
        preparationTimeController.text.length > 0 &&
        dificultyLevelController.text.length > 0) {
      var recipeId;
      recipeId = await apiManager.addRecipe(new Recipe(
          creatorName: '${nameController.text} ${lastnameController.text}',
          name: recipeNameController.text,
          ingredients: ingredients,
          preparation: preparationController.text,
          preparationTime: preparationTimeController.text,
          dificultyLevel: dificultyLevelController.text));
      if (recipeId == null) {
        return;
      }
    }
    nameController.clear();
    lastnameController.clear();
    recipeNameController.clear();
    preparationController.clear();
    preparationTimeController.clear();
    dificultyLevelController.clear();

    // SNACKBAR
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      content: Text('Receita cadastrada com sucesso!',
          style: TextStyle(color: Colors.white)),
      action: SnackBarAction(
        label: 'Limpar',
        textColor: Colors.white,
        onPressed: () {},
      ),
    ));

    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Recipes()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF3E0),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 54, bottom: 62),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 19),
                  child: PageHeader(
                    onGoBack: () => showDialog(
                        context: context,
                        builder: (context) {
                          return WarningDialog(
                            title: "Abandonar o cadatro de receita?",
                            content:
                                "Todos os dados fornecidos serão perdidos.",
                            primaryButtonText: "Confirmar",
                            primaryButtonAction: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            secondaryButtonText: "Cancelar",
                            secondaryButtonAction: () {
                              Navigator.pop(context);
                            },
                          );
                        }),
                    title: 'Nova Receita',
                  )),
              SizedBox(
                height: 24.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Indentificação',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF333333))),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Input(
                            label: 'Nome',
                            controller: nameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Informe o nome';
                              }
                              return null;
                            },
                          ),
                          SizedBox(width: 30),
                          Input(
                            label: 'Sobrenome',
                            controller: lastnameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Informe o sobrenome';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Input(
                            label: 'Nome da receita',
                            controller: recipeNameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Informe o nome da receita';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 19),
                child: Column(
                  children: [
                    Text('Ingredientes',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF333333))),
                  ],
                ),
              ),
              Container(
                height: 28,
                margin: EdgeInsets.symmetric(vertical: 18),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ingredients != null && ingredients.length > 0
                        ? <Widget>[
                            for (var i in ingredients)
                              FoodChip(
                                food: i.food,
                                substituteFood: i.substituteFood != null
                                    ? i.substituteFood
                                    : null,
                                onRemove: () {
                                  setState(() {
                                    ingredients.remove(i);
                                  });
                                },
                              ),
                          ]
                        : [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 19),
                              child: Text(
                                'Adcione ingredientes à receita...',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFFB2B2B2)),
                              ),
                            )
                          ]),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 19),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: kElevationToShadow[4],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Input(
                      label: 'Ingrediente',
                      controller: foodController,
                    ),
                    SizedBox(width: 30),
                    Input(
                      label: 'Substituto',
                      controller: substituteFoodController,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 19, left: 19, top: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButton(
                        text: 'Adcionar',
                        textColor: Theme.of(context).primaryColor,
                        buttonColor: Theme.of(context).primaryColor,
                        action: _addIngredient,
                        outlined: true),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Modo de preparo',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF333333))),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Input(
                            maxLines: 8,
                            controller: preparationController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Informe o modo de preparo';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 19, vertical: 20),
                child: Row(
                  children: [
                    Input(
                      label: 'Tempo',
                      controller: preparationTimeController,
                      type: 'number',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe o tempo de preparo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(width: 30),
                    Input(
                      label: 'Dificuldade',
                      controller: dificultyLevelController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe a dificuldade';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(19, 13, 19, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButton(
                      text: 'Cadastrar',
                      textColor: Colors.white,
                      buttonColor: Theme.of(context).primaryColor,
                      action: _createRecipe,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
