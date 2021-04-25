/* import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager {
  Future<Recipe> addRecipe(Recipe r) async {
    var client = http.Client();
    var recipe;

    try {
      var response = await client.post(Uri.parse("${Strings.baseURL}/recipe/register"),
          body: r.toJson());
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);

        recipe = Recipe.fromJson(jsonMap);
      }
    } catch (Exception) {
      return recipe;
    }
    return recipe;
  }

  Future<List<Recipe>> getRecipes() async {
    var client = http.Client();
    var recipes;

    try {
      var response = await client.post(Uri.parse("${Strings.baseURL}/recipe/register"));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);

        recipes = Recipe.fromJson(jsonMap);
      }
    } catch (Exception) {
      return recipes;
    }
    return recipes;
  }

  Future<Food> addFood(String foodName) async {
    var client = http.Client();
    var food;

    try {
      var response =
          await client.post(Uri.parse("${Strings.baseURL}food/register?name=$foodName"));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);

        food = Food.fromJson(jsonMap);
        print(food.toString());
      }
    } catch (Exception) {
      return food;
    }
    return food;
  }
}
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fastrecipes/core/theme/app_colors.dart';

void checkAuth({BuildContext context, FirebaseAuth auth, dynamic route}) async {
  auth.authStateChanges().listen((user) {
    if (user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => route));
    }
  });
}

void showError({BuildContext context, String errorMessage}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 77.0),
    backgroundColor: AppColors.errorColor,
    behavior: SnackBarBehavior.floating,
    content: Text(errorMessage, style: TextStyle(color: AppColors.white)),
    action: SnackBarAction(
      label: 'Limpar',
      textColor: AppColors.white,
      onPressed: () {},
    ),
  ));
}
