import 'dart:convert';
// To parse this JSON data, do
//
//     final recipe = recipeFromJson(jsonString);

Recipe recipeFromJson(String str) => Recipe.fromJson(json.decode(str));

String recipeToJson(Recipe data) => json.encode(data.toJson());

class Recipe {
  Recipe({
    this.key,
    this.creatorName,
    this.name,
    this.preparationTime,
    this.preparation,
    this.dificultyLevel,
    this.ingredients,
  });

  String key;
  String creatorName;
  String name;
  String preparationTime;
  String preparation;
  String dificultyLevel;
  List<Ingredient> ingredients;

  factory Recipe.fromJson(MapEntry<dynamic, dynamic> json) => Recipe(
        key: json.key,
        creatorName: json.value["creatorName"],
        name: json.value["name"],
        preparationTime: json.value["preparationTime"],
        preparation: json.value["preparation"],
        dificultyLevel: json.value["dificultyLevel"],
        ingredients: List<Ingredient>.from(
            json.value["ingredients"].map((x) => Ingredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "creatorName": creatorName,
        "name": name,
        "preparationTime": preparationTime,
        "preparation": preparation,
        "dificultyLevel": dificultyLevel,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
      };
}

/* enum DificultyLevels { facil, medio, dificil } */

const dificultyLevels = [
  {"id": 1, "level": "Fácil"},
  {"id": 2, "level": "Médio"},
  {"id": 3, "level": "Difícil"},
];

class Ingredient {
  Ingredient({
    this.food,
    this.substituteFood,
  });

  String food;
  String substituteFood;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        food: json["food"],
        substituteFood: json["substituteFood"],
      );

  Map<String, dynamic> toJson() => {
        "food": food,
        "substituteFood": substituteFood,
      };
}
