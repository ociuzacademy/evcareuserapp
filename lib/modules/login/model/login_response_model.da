// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    String? status;
    String? message;
    String? userId;

    LoginResponseModel({
        this.status,
        this.message,
        this.userId,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        status: json["status"],
        message: json["message"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_id": userId,
    };
}
