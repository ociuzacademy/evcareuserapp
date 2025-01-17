// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UserLoginModel welcomeFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String welcomeToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
    String? username;
    String? password;
    int? userid;

    UserLoginModel({
        this.username,
        this.password,
        this.userid,
    });

    factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        username: json["username"],
        password: json["password"],
        userid: json["userid"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "userid":userid,
    };
}
