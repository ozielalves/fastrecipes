import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/core/app_endpoints.dart';
import 'package:fastrecipes/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager {
  Future<String> addUser(IUser u) async {
    var client = http.Client();
    var registeredUserKey;
    try {
      final response = await client.post(
          Uri.parse("${Endpoint.baseURL}/user.json"),
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

  Future<Object> updateUser({String userKey, Object changes}) async {
    var client = http.Client();
    var persistedChanges;

    try {
      final response = await client.patch(
          Uri.parse("${Endpoint.baseURL}/user/$userKey.json"),
          body: jsonEncode(changes));
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = jsonDecode(jsonString);

        persistedChanges = jsonMap;
      }
    } catch (Exception) {
      print('Não foi possível editar o usuário');
      return null;
    } finally {
      client.close();
    }
    return persistedChanges;
  }

  Future<dynamic> getUserKeyByEmail(String email) async {
    var client = http.Client();
    var userKey;
    try {
      final response =
          await client.get(Uri.parse('${Endpoint.baseURL}/user.json'));
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = jsonDecode(jsonString);

        userKey = jsonMap.keys.firstWhere((k) => jsonMap[k]['email'] == email,
            orElse: () => null);
      }
    } catch (Exception) {
      print('Não foi possível recuperar o usuário de e-mail $email');
      return null;
    } finally {
      client.close();
    }
    return userKey;
  }

  Future<dynamic> getUserByEmail(String email) async {
    var client = http.Client();
    IUser userLoggedIn;

    try {
      final response =
          await client.get(Uri.parse('${Endpoint.baseURL}/user.json'));
      if (response.statusCode == 200) {
        final jsonString = response.body;
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        List<IUser> users =
            jsonMap.entries.map((e) => IUser.fromJsonEntry(e)).toList();
        userLoggedIn = users.where((u) => u.email == email).first;
      }
    } catch (Exception) {
      print(Exception);
      print('Não foi possível recuperar o usuário de e-mail $email');
      return null;
    } finally {
      client.close();
    }
    return userLoggedIn;
  }

  Future<IUser> getUserByKey(String key) async {
    var client = http.Client();
    IUser user;
    try {
      final response =
          await client.get(Uri.parse('${Endpoint.baseURL}/user/$key.json'));
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = jsonDecode(jsonString);
        user = IUser.fromKeyAndJson(key, jsonMap);
      }
    } catch (Exception) {
      print('Não foi possível recuperar o usuário pela chave');
      return null;
    } finally {
      client.close();
    }
    return user;
  }

  Future<Object> toggleRecipeLove(String userKey, String recipeKey) async {
    var client = http.Client();
    IUser updatedUser;
    var changes;
    try {
      updatedUser = await getUserByKey(userKey);
      if (updatedUser != null) {
        if (updatedUser.favoriteRecipesKeys.contains(recipeKey)) {
          updatedUser.favoriteRecipesKeys.remove(recipeKey);
        } else {
          updatedUser.favoriteRecipesKeys.add(recipeKey);
        }
        print(updatedUser.favoriteRecipesKeys.toString());
        final response = await client.patch(
            Uri.parse("${Endpoint.baseURL}/user/$userKey.json"),
            body: jsonEncode(
                {"favoriteRecipesKeys": updatedUser.favoriteRecipesKeys}));
        if (response.statusCode == 200) {
          final jsonString = response.body;
          final jsonMap = jsonDecode(jsonString);

          changes = jsonMap;
        }
      }
    } catch (Exception) {
      print(Exception);
      print('Não foi possível adcionar a receita favorita');
      return null;
    } finally {
      client.close();
    }
    return changes;
  }

  Future<String> addRecipe(Recipe r) async {
    var client = http.Client();
    var recipeId;
    try {
      final response = await client.post(
          Uri.parse("${Endpoint.baseURL}/recipe.json"),
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

  Future<Object> updateRecipe({String recipeKey, Object changes}) async {
    var client = http.Client();
    var persistedChanges;

    try {
      final response = await client.patch(
          Uri.parse("${Endpoint.baseURL}/user/$recipeKey.json"),
          body: jsonEncode(changes));
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = jsonDecode(jsonString);

        persistedChanges = jsonMap;
      }
    } catch (Exception) {
      print('Não foi possível editar a receita');
      return null;
    } finally {
      client.close();
    }
    return persistedChanges;
  }

  Future<void> deleteRecipe(String recipeKey) async {
    var client = http.Client();

    try {
      await client
          .delete(Uri.parse("${Endpoint.baseURL}/recipe/$recipeKey.json"));
    } catch (Exception) {
      print('Não foi possível deletar a receita');
      return null;
    } finally {
      client.close();
    }
  }

  Future<List<Recipe>> getRecipes() async {
    var client = http.Client();
    List<Recipe> recipes;

    try {
      var response =
          await client.get(Uri.parse("${Endpoint.baseURL}/recipe.json"));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<dynamic, dynamic> jsonMap = jsonDecode(jsonString);
        recipes = jsonMap.entries.map((e) => Recipe.fromJson(e)).toList();
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
          Uri.parse("${Endpoint.baseURL}/food.json"),
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
