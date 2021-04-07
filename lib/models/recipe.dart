import 'dart:convert';

Food foodFromJson(String str) => Food.fromJson(json.decode(str));

String foodToJson(Food data) => json.encode(data.toJson());

class Food {
  Food({
    this.id,  
    this.name,
  });

  int id;
  String name;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
// To parse this JSON data, do
//
//     final recipe = recipeFromJson(jsonString);

Recipe recipeFromJson(String str) => Recipe.fromJson(json.decode(str));

String recipeToJson(Recipe data) => json.encode(data.toJson());

class Recipe {
  Recipe({
    this.creatorName,
    this.name,
    this.preparationTime,
    this.preparation,
    this.dificultyLevel,
    this.ingredients,
  });

  String creatorName;
  String name;
  String preparationTime;
  String preparation;
  String dificultyLevel;
  List<Ingredient> ingredients;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        creatorName: json["creatorName"],
        name: json["name"],
        preparationTime: json["preparationTime"],
        preparation: json["preparation"],
        dificultyLevel: json["dificultyLevel"],
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
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
