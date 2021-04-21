/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/core/strings.dart';
import 'package:fastrecipes/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager {


  void addRecipe(Recipe r) async {
    Map<String, dynamic> data = r.toJson();

    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('recipes');
      collectionReference.add(data);
    } catch (Exception) {
      print('Não foi possível criar a receita');
      return null;
    }
  }

  Future<Stream<QuerySnapshot>> getRecipes() async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('recipes');
      return collectionReference.snapshots();
    } catch (Exception) {
      print('Não foi possível criar a receita');
      return null;
    }
  }
}
 */