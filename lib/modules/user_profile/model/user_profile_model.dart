// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    int? id;
    String? name;
    String? username;
    String? phone;
    String? email;
    String? password;
    dynamic image;

    UserProfileModel({
        this.id,
        this.name,
        this.username,
        this.phone,
        this.email,
        this.password,
        this.image,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "phone": phone,
        "email": email,
        "password": password,
        "image": image,
    };
}
