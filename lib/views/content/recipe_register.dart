import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_typhography.dart';
import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/models/user.dart';
import 'package:fastrecipes/views/content/content.dart';
import 'package:fastrecipes/views/content/components/action_button.dart';
import 'package:fastrecipes/views/content/components/food_chip.dart';
import 'package:fastrecipes/views/content/components/input.dart';
import 'package:fastrecipes/views/content/components/page_header.dart';
import 'package:fastrecipes/views/content/components/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fastrecipes/providers/api_%20fastrecipe.dart';
import 'package:flutter/services.dart';

class RecipeRegister extends StatefulWidget {
  final IUser userLoggedIn;

  RecipeRegister({Key key, @required this.userLoggedIn}) : super(key: key);

  @override
  _RecipeRegisterState createState() => _RecipeRegisterState();
}

class _RecipeRegisterState extends State<RecipeRegister> {
  ApiManager apiManager = ApiManager();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Ingredient> ingredients = [];
  Recipe recipe;
  IUser currentUser;
  bool _isFoodRegisterLoading = false;

  String _name,
      _lastname,
      _recipeName,
      _preparation,
      _preparationTime,
      _dificultyLevel;

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
    currentUser = widget.userLoggedIn;
    nameController.text = widget.userLoggedIn.name;
    lastnameController.text = widget.userLoggedIn.lastname;
    ingredients = [];
  }

  void _toggleFoodRegisterIsLoading() {
    setState(() {
      _isFoodRegisterLoading = !_isFoodRegisterLoading;
    });
  }

  bool _isFormEmpty() {
    return recipeNameController.text.isEmpty &&
        preparationController.text.isEmpty &&
        preparationTimeController.text.isEmpty &&
        dificultyLevelController.text.isEmpty;
  }

  Future<void> _addIngredient() async {
    if (foodController != null && foodController.text.length > 0) {
      _toggleFoodRegisterIsLoading();
      var ingredient = {};
      ingredient["foodId"] = await apiManager.addFood(foodController.text);
      if (substituteFoodController != null &&
          substituteFoodController.text.length > 0) {
        ingredient["substituteFoodId"] =
            await apiManager.addFood(substituteFoodController.text);
      }
      if (ingredient != null) {
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
      }
      foodController.clear();
      substituteFoodController.clear();
      _toggleFoodRegisterIsLoading();
    }
  }

  Future<void> _createRecipe() async {
    if (ingredients.length == 0) {
      // SNACKBAR
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
        backgroundColor: AppColors.errorColor,
        behavior: SnackBarBehavior.floating,
        content: Text('Por favor adcione ingredientes à receita',
            style: TextStyle(color: AppColors.white)),
        action: SnackBarAction(
          label: 'Limpar',
          textColor: AppColors.white,
          onPressed: () {},
        ),
      ));
      return;
    }
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        var recipeId;
        recipeId = await apiManager.addRecipe(new Recipe(
            creatorName: '$_name $_lastname',
            name: _recipeName,
            ingredients: ingredients,
            preparation: _preparation,
            preparationTime: _preparationTime,
            dificultyLevel: _dificultyLevel));
        if (recipeId == null) {
          return;
        }
        nameController.clear();
        lastnameController.clear();
        recipeNameController.clear();
        preparationController.clear();
        preparationTimeController.clear();
        dificultyLevelController.clear();
        // SNACKBAR
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 77.0),
          backgroundColor: AppColors.successColor,
          behavior: SnackBarBehavior.floating,
          content: Text('Receita cadastrada com sucesso',
              style: TextStyle(color: AppColors.white)),
          action: SnackBarAction(
            label: 'Limpar',
            textColor: AppColors.white,
            onPressed: () {},
          ),
        ));

        return Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Recipes()));
      } catch (Exception) {
        print("Não foi possível cadastrar a receita");
      }
    } else {
      // SNACKBAR
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 77.0),
        backgroundColor: AppColors.errorColor,
        behavior: SnackBarBehavior.floating,
        content: Text('Existem campos não preenchidos ou inválidos',
            style: TextStyle(color: AppColors.white)),
        action: SnackBarAction(
          label: 'Limpar',
          textColor: AppColors.white,
          onPressed: () {},
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 19),
                      child: PageHeader(
                        onGoBack: () {
                          if (_isFormEmpty()) {
                            Navigator.pop(context);
                          } else {
                            showDialog(
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
                                });
                          }
                        },
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
                        Text('Indentificação', style: AppTyphography.body1),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Input(
                                label: 'Nome',
                                controller: nameController,
                                type: TextInputType.name,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Informe o nome';
                                  }
                                  return null;
                                },
                                onSaved: (input) => _name = input,
                              ),
                              SizedBox(width: 20),
                              Input(
                                label: 'Sobrenome',
                                controller: lastnameController,
                                type: TextInputType.name,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Informe o sobrenome';
                                  }
                                  return null;
                                },
                                onSaved: (input) => _lastname = input,
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
                                type: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Informe o nome da receita';
                                  }
                                  return null;
                                },
                                onSaved: (input) => _recipeName = input,
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
                        Text('Ingredientes', style: AppTyphography.body1),
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
                                    style: AppTyphography.body2Faded,
                                  ),
                                )
                              ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 19),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: kElevationToShadow[4],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Input(
                          label: 'Ingrediente',
                          controller: foodController,
                          type: TextInputType.text,
                        ),
                        SizedBox(width: 20),
                        Input(
                          label: 'Substituto',
                          controller: substituteFoodController,
                          type: TextInputType.text,
                        ),
                        SizedBox(width: 20),
                        ActionButton(
                          icon: _isFoodRegisterLoading
                              ? SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                )
                              : Icon(Icons.add,
                                  size: 30, color: AppColors.white),
                          iconColor: AppColors.white,
                          buttonColor: AppColors.primaryColor,
                          padding: EdgeInsets.all(14),
                          action: _addIngredient,
                          minWidth: double.minPositive,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(19, 20, 19, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Modo de preparo', style: AppTyphography.body1),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Input(
                                maxLines: 8,
                                controller: preparationController,
                                type: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Informe o modo de preparo';
                                  }
                                  return null;
                                },
                                onSaved: (input) => _preparation = input,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Input(
                          label: 'Tempo',
                          controller: preparationTimeController,
                          type: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o tempo de preparo';
                            }
                            return null;
                          },
                          onSaved: (input) => _preparationTime = input,
                        ),
                        SizedBox(width: 20),
                        Input(
                          label: 'Dificuldade',
                          controller: dificultyLevelController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe a dificuldade';
                            }
                            return null;
                          },
                          onSaved: (input) => _dificultyLevel = input,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(19, 13, 19, 0),
                      child: ActionButton(
                        text: 'Cadastrar',
                        textColor: AppColors.white,
                        minWidth: double.maxFinite,
                        buttonColor: AppColors.primaryColor,
                        action: _createRecipe,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
