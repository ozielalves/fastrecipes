import 'dart:convert';

IUser userFromJson(String str) => IUser.fromJson(json.decode(str));

String userToJson(IUser data) => json.encode(data.toJson());

class IUser {
  IUser({
    this.key,
    this.name,
    this.lastname,
    this.email,
    this.favoriteRecipesKeys,
  });

  String key;
  String name;
  String lastname;
  String email;
  List<String> favoriteRecipesKeys;

  factory IUser.fromJson(Map<String, dynamic> json) => IUser(
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        favoriteRecipesKeys:
            List<String>.from(json["favoriteRecipesKeys"].map((x) => x)),
      );

  factory IUser.fromKeyAndJson(String key, Map<String, dynamic> json) => IUser(
        key: key,
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        favoriteRecipesKeys:
            List<String>.from(json["favoriteRecipesKeys"].map((x) => x)),
      );

  factory IUser.fromJsonEntry(MapEntry<String, dynamic> json) => IUser(
        key: json.key,
        name: json.value["name"],
        lastname: json.value["lastname"],
        email: json.value["email"],
        favoriteRecipesKeys:
            List<String>.from(json.value["favoriteRecipesKeys"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "lastname": lastname,
        "email": email,
        "favoriteRecipesKeys":
            List<dynamic>.from(favoriteRecipesKeys.map((x) => x)),
      };
}
