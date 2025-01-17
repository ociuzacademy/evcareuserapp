// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UserRegModel welcomeFromJson(String str) => UserRegModel.fromJson(json.decode(str));

String welcomeToJson(UserRegModel data) => json.encode(data.toJson());

class UserRegModel {
    String? status;
    String? message;

    UserRegModel({
        this.status,
        this.message,
    });

    factory UserRegModel.fromJson(Map<String, dynamic> json) => UserRegModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
