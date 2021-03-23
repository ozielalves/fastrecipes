import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager {
  Future<Recipe> addRecipe(Recipe r) async {
    var client = http.Client();
    var recipe;

    try {
      var response = await client.post("${Strings.baseURL}/recipe/register",
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
      var response = await client.post("${Strings.baseURL}/recipe/register");
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
          await client.post("${Strings.baseURL}food/register?name=$foodName");
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
