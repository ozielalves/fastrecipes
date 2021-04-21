import 'dart:convert';

IUser userFromJson(String str) => IUser.fromJson(json.decode(str));

String userToJson(IUser data) => json.encode(data.toJson());

class IUser {
    IUser({
        this.name,
        this.lastname,
        this.email,
        this.favoriteRecipesIds,
    });

    String name;
    String lastname;
    String email;
    List<String> favoriteRecipesIds;

    factory IUser.fromJson(Map<String, dynamic> json) => IUser(
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        favoriteRecipesIds: List<String>.from(json["favoriteRecipesIds"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "favoriteRecipesIds": List<dynamic>.from(favoriteRecipesIds.map((x) => x)),
    };
}