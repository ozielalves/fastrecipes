class Food {
  int _id;
  String name;

  Food(this._id, this.name);
}

class Igredient {
  int _id;
  Food food;
  Food foodSubstitute;

  Igredient(this._id, this.food, this.foodSubstitute);
}

class Recipe {
  int _id;
  String userName;
  String name;
  List<Igredient> igredients; // mandar lista de ids de igrediente?
  String preparation;
  int preparationTime;
  String dificultyLevel;

  Recipe(this._id, this.userName, this.name, this.igredients, this.preparation,
      this.preparationTime, this.dificultyLevel);

  @override
  toString() =>
      "Recipe: {id: $_id, userName: $userName, name: $name, igredients: $igredients, preparation: $preparation, preparationTime: $preparation, dificultyLevel: $dificultyLevel}";
}

// http://localhost:4101/recipe

/* final List<Recipe> recipes = _stocks
    .map((s) =>
        Stock(s["symbol"], s["companyName"], s["price"], s["changePercent"]))
    .toList(growable: false); */

/* final List<Map<String, Object>> _stocks = [
  {
    "symbol": "BIAS",
    "companyName": "Boticario Intancia Análise Saudável",
    "price": "7.90",
    "changePercent": "3.0"
  },
  {
    "symbol": "BIAS",
    "companyName": "Boticario Intancia Análise Saudável",
    "price": "7.90",
    "changePercent": "3.0"
  },
  {
    "symbol": "BIAS",
    "companyName": "Boticario Intancia Análise Saudável",
    "price": "7.90",
    "changePercent": "3.0"
  },
  {
    "symbol": "BIAS",
    "companyName": "Boticario Intancia Análise Saudável",
    "price": "7.90",
    "changePercent": "3.0"
  },
]; */
