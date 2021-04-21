import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/core/app_strings.dart';
import 'package:fastrecipes/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager {
  Future<String> addUser(IUser u) async {
    var client = http.Client();
    var registeredUserKey;
    try {
      final response = await client.post(
          Uri.parse("${Strings.baseURL}/user.json"),
          body: jsonEncode(u.toJson()));
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = jsonDecode(jsonString);

        registeredUserKey = jsonMap['name'];
      }
    } catch (Exception) {
      print('Não foi possível cadastrar o usuário');
      return null;
    } finally {
      client.close();
    }
    return registeredUserKey;
  }

  Future<dynamic> addFavoriteRecipe(String userId, String recipeKey) async {
    var client = http.Client();
    var registeredUser;
    try {
      final response = await client.patch(
          Uri.parse("${Strings.baseURL}/user.json"),
          body: {"$userId/favoriteRecipes": []});
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = jsonDecode(jsonString);

        registeredUser = jsonMap;
      }
    } catch (Exception) {
      print('Não foi possível adcionar a receita favorita');
      return null;
    } finally {
      client.close();
    }
    return registeredUser;
  }

  Future<dynamic> getUserKeyByEmail(String email) async {
    var client = http.Client();
    var userKey;
    try {
      final response =
          await client.get(Uri.parse('${Strings.baseURL}/user.json'));
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = jsonDecode(jsonString);

        userKey = jsonMap.keys.firstWhere((k) => jsonMap[k]['email'] == email,
            orElse: () => null);
        print(userKey);
      }
    } catch (Exception) {
      print('Não foi possível recuperar o usuário de e-mail $email');
      return null;
    } finally {
      client.close();
    }
    return userKey;
  }

  Future<IUser> getUserByKey(String key) async {
    var client = http.Client();
    var user;
    try {
      final response =
          await client.get(Uri.parse('${Strings.baseURL}/user/$key.json'));
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = jsonDecode(jsonString);

        user = IUser.fromJson(jsonMap);
        print(user);
      }
    } catch (Exception) {
      print('Não foi possível recuperar o usuário pela chave');
      return null;
    } finally {
      client.close();
    }
    return user;
  }

  Future<String> addRecipe(Recipe r) async {
    var client = http.Client();
    var recipeId;
    print(r.toJson());
    try {
      final response = await client.post(
          Uri.parse("${Strings.baseURL}/recipe.json"),
          body: jsonEncode(r.toJson()));
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = jsonDecode(jsonString);

        recipeId = jsonMap['name'];
      }
    } catch (Exception) {
      print('Não foi possível criar a receita');
      return null;
    } finally {
      client.close();
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
      var response =
          await client.get(Uri.parse("${Strings.baseURL}/recipe.json"));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<dynamic, dynamic> jsonMap = jsonDecode(jsonString);
        recipes = jsonMap.entries.map((e) => Recipe.fromJson(e)).toList();
        print(recipes.toString());
      }
    } catch (Exception) {
      print('Não foi possível recuperar as receitas');
      return null;
    } finally {
      client.close();
    }
    return recipes;
  }

  Future<String> addFood(String foodName) async {
    var client = http.Client();
    var foodId;

    try {
      var response = await client.post(
          Uri.parse("${Strings.baseURL}/food.json"),
          body: jsonEncode({'name': foodName}));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);

        foodId = jsonMap['name'];
      }
    } catch (Exception) {
      print('Não foi possível criar a comida');
      return null;
    } finally {
      client.close();
    }
    return foodId;
  }
}
