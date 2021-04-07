import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager {
  final _baseUrl = 'https://fast-recipes-oz-default-rtdb.firebaseio.com/';

  Future<String> addRecipe(Recipe r) async {
    var client = http.Client();
    var recipeId;
    print(r.toJson());
    try {
      final response = await client.post("$_baseUrl/recipe.json",
          body: jsonEncode(r.toJson()));
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = jsonDecode(jsonString);

        recipeId = jsonMap['name'];
      }
    } catch (Exception) {
      print('Não foi possível criar a receita');
      return null;
    }
    return recipeId;
  }

  /* Recipe _reviver(String key, value) {
    if (key != null && value is Map && key.contains("-")) {
      return new Recipe.fromJson(value);
    }
  } */

  List<Recipe> _recipesFromHashMap(Map jsonMap) {
    List<Recipe> recipes;
    for (var i = 0; i < jsonMap.length; i++) {
      if (jsonMap[i].key != null &&
          jsonMap[i].value is Map &&
          jsonMap[i].key.contains("-")) {
        print(jsonMap[i].value);
        recipes.add(new Recipe.fromJson(jsonMap[i].value));
      }
      return recipes;
    }
  }

  Future<List<Recipe>> getRecipes() async {
    var client = http.Client();
    List<Recipe> recipes;

    try {
      var response = await client.get("$_baseUrl/recipe.json");
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<dynamic, dynamic> jsonMap = jsonDecode(jsonString);
        recipes = jsonMap.entries.map((e) => Recipe.fromJson(e.value)).toList();
      }
    } catch (Exception) {
      print('Não foi possível recuperar as receitas');
      return null;
    }
    return recipes;
  }

  Future<String> addFood(String foodName) async {
    var client = http.Client();
    var foodId;

    try {
      var response = await client.post("$_baseUrl/food.json",
          body: jsonEncode({'name': foodName}));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);

        foodId = jsonMap['name'];
      }
    } catch (Exception) {
      print('Não foi possível criar a comida');
      return null;
    }
    return foodId;
  }
}
